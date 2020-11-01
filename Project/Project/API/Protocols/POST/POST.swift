import Foundation

enum POSTRequestType {
    case contentType
}

protocol POST {
    func post(_ type: POSTRequestType , _ request: URLRequest, _ parameters: [String:Any], _ serverConfirmation: ((Data) -> Void)?)
}

extension POST {
    fileprivate func dataTask(_ request: URLRequest, _ competion: @escaping (Data) -> Void) {
        URLSession.shared.dataTask(with: request) { data,_,_ in
            if let data = data {
                competion(data)
            }
        }.resume()
    }
    
    func post(_ type: POSTRequestType , _ request: URLRequest, _ parameters: [String:Any], _ serverConfirmation: ((Data) -> Void)? = nil) {
        var request = request
        
        switch type {
            case .contentType:
            DispatchQueue(label: "post.contentType", qos: .utility).async {
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.httpMethod = httpMethod.POST.rawValue
                request.httpBody = parameters.percentEncoded()
                dataTask(request, { data in
                    if let completion = serverConfirmation {
                        completion(data)
                    }
                })
            }
            break
            // default: break
        }
    }
}
