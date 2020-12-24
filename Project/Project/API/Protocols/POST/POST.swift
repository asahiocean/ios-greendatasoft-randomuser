import Foundation

enum POSTRequestType {
    case contentType
}

protocol POST {
    func post(_ type: POSTRequestType , _ request: URLRequest, _ parameters: [String:Any], _ serverConfirmation: ((Data) -> Void)?)
}

extension POST {
    func post(_ type: POSTRequestType , _ request: URLRequest, _ parameters: [String:Any], _ serverConfirmation: ((Data) -> Void)? = nil) {
        var request = request
        
        switch type {
            case .contentType:
            DispatchQueue(label: "post.contentType", qos: .background).async {
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.httpMethod = httpMethod.POST.rawValue
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [.prettyPrinted])
                } catch let error {
                    print(error.localizedDescription)
                }
                
                guard let completion = serverConfirmation else { return }
                URLSession.shared.dataTask(with: request) { data,_,_ in
                    if let data = data {
                        completion(data)
                    }
                }.resume()
            }
            break
            // default: break
        }
    }
}
