import Foundation

protocol GET {
    func get(_ request: URLRequest, _ completion: @escaping (Data?,URLResponse?,Error?) -> Void)
}

extension GET {
    internal func get(_ request: URLRequest, _ completion: @escaping (Data?,URLResponse?,Error?) -> Void) {
        URLSession.shared.dataTask(with: request) { (data,resp,error) in
            if let status = (resp as? HTTPURLResponse)?.statusCode {
                switch status {
                case (200...299):
                    if let data = data {
                        completion(data,resp,error)
                    }
                case 299...: // == error
                    completion(nil,nil,nil)
                // fallthrough // принудительно "проваливается" к следующему кейсу
                default: break
                }
            }
        }.resume()
    }
}
