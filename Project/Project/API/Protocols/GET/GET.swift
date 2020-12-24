import Foundation

protocol GET {
    func get(_ request: URLRequest, _ completion: @escaping (Data?,URLResponse?,Error?) -> Void)
}

extension GET {
    func get(_ request: URLRequest, _ completion: @escaping (Data?,URLResponse?,Error?) -> Void) {
        DispatchQueue(label: "com.request.get", qos: .background).async {
            URLSession.shared.dataTask(with: request) { (data,resp,error) in
                guard let data = data,
                      let status = (resp as? HTTPURLResponse)?.statusCode else { completion(nil,nil,nil); return }
                switch status {
                case 200...299:
                    completion(data,resp,error);
                default:
                    completion(nil,nil,nil);
                }
            }.resume()
        }
    }
}
