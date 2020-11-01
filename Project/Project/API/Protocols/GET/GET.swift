import Foundation

enum GETRequestType {
    case dataTask
}

protocol GET {
    func get(_ type: GETRequestType , _ request: URLRequest, _ completion: @escaping (Data?) -> Void)
}

extension GET {
    func get(_ type: GETRequestType, _ request: URLRequest, _ completion: @escaping (Data?) -> Void) {
        switch type {
            case .dataTask:
                _request(request) { (data, _, _) -> Void in
                    if let data = data {
                        completion(data)
                    } else {
                        completion(nil)
                    }
                }
            default: break
        }
    }
}

extension GET {
    fileprivate func _request(_ request: URLRequest, _ completion: @escaping (Data?, URLResponse?, Error?) throws -> Void?) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let status = (response as? HTTPURLResponse)?.statusCode {
                print("Status request - \(status)")
                switch status {
                case (200...299):
                    if let data = data {
                        print("🆗 \(type(of: self)).get: data received:", data.count)
                        do {
                            try completion(data, response, error)
                        } catch let dataLoadererror as NSError {
                            print("🔴 \(type(of: self)) dataLoadererror:", dataLoadererror.localizedDescription)
                        }
                    }
                case 299...: // == error
                    try? completion(data, response, error)
                // fallthrough // принудительно "проваливается" к следующему кейсу
                default:
                    break
                }
            }
        }.resume()
    }
}
