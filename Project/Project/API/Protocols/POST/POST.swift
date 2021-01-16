import Foundation

enum POSTType {
    case contentType
}

protocol POST {
    func post(_ type: POSTType , _ request: URLRequest?, _ parameters: [String:Any], _ confirm: ((Data)->())?)
}

extension POST {
    func post(_ type: POSTType , _ request: URLRequest?, _ parameters: [String:Any], _ confirm: ((Data)->())? = nil) {
        guard var request = request else { return }
        
        switch type {
        case .contentType:
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
