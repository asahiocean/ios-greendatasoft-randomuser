import Foundation

enum POSTType {
    case json
}

protocol GETPOST {
    static func get(_ request: URLRequest, _ completion: @escaping (Data?,URLResponse?,Error?) -> Void)
    static func post(_ type: POSTType , _ request: URLRequest?, _ parameters: [String:Any], _ confirm: ((Data)->())?)
}

extension GETPOST {
    //MARK: -- GET
    static func get(_ request: URLRequest, _ completion: @escaping (Data?,URLResponse?,Error?) -> Void) {
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
    
    //MARK: -- POST
    static func post(_ type: POSTType , _ request: URLRequest?, _ parameters: [String:Any], _ confirm: ((Data)->())? = nil) {
        guard var request = request else { return }
        
        switch type {
        case .json:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            DispatchQueue(label: "com.request.post.contentType", qos: .background).async {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [.prettyPrinted])
                    URLSession.shared.dataTask(with: request) { data,_,_ in
                        guard let completion = confirm, let data = data else { return }
                        completion(data)
                    }.resume()
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
