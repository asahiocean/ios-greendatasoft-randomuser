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
                _request(request) { data -> Void in
                    if (data?.count ?? 0) > 0, let data = data {
                        completion(data)
                    } else {
                        completion(nil)
                    }
                }
            break
            // default: break
        }
    }
}

extension GET {
    fileprivate func _request(_ request: URLRequest, _ completion: @escaping (Data?) -> Void?) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let status = (response as? HTTPURLResponse)?.statusCode {
                switch status {
                case (200...299):
                    if (data?.count ?? 0) > 0, let data = data {
                        completion(data)
                    }
                case 299...: // == error
                    completion(nil)
                // fallthrough // принудительно "проваливается" к следующему кейсу
                default: break
                }
            }
        }.resume()
    }
}
