import Foundation

enum POSTRequestType {
    case contentType
}

protocol POST {
    func post(_ type: POSTRequestType, _ request: URLRequest, _ parameters: [String:Any], _ serverConfirmation: ((Data) throws -> Void)?)
}

extension POST {
    func post(_ type: POSTRequestType , _ request: URLRequest, _ parameters: [String:Any], _ serverConfirmation: ((Data) throws -> Void)? = nil) {
        var request = request
        switch type {
        case .contentType:
            DispatchQueue(label: "POST.contentTypeRequest.utility", qos: .utility).async {
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.httpMethod = httpMethod.POST.rawValue
                request.httpBody = parameters.percentEncoded()
            }
            default:
                break
        }
        URLSession.shared.dataTask(with: request) { data,response,error in
            if let data = data {
                guard let competion = serverConfirmation else { return }
                try? competion(data)
            }
        }.resume()
    }
}
