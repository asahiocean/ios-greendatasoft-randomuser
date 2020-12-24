import Foundation

protocol GET {
    func get(_ request: URLRequest, _ completion: @escaping (Data?,URLResponse?,Error?) -> Void)
}

extension GET {
    func get(_ request: URLRequest, _ completion: @escaping (Data?,URLResponse?,Error?) -> Void) {
        DispatchQueue(label: "com.load.get.data", qos: .background).async {
        URLSession.shared.dataTask(with: request) { (data,resp,error) in
            if let data = data, let status = (resp as? HTTPURLResponse)?.statusCode {
                switch status {
                case (200...299):
                    completion(data,resp,error)
                case 299...:
                    completion(nil,nil,nil)
                default:
                    break
                }
            } else { // NO INTERNET
                completion(nil,nil,nil)
            }
        }.resume()
        }
    }
}
