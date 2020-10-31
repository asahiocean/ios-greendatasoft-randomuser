import Foundation

enum POSTRequestType {
    case contentType
}

protocol POST {
    func post(_ type: POSTRequestType, _ request: URLRequest, _ parameters: [String:Any], _ competion: ((URLRequest) throws -> Void)?)
}

extension POST {
    func post(_ type: POSTRequestType , _ request: URLRequest, _ parameters: [String:Any], _ serverConfirmation: ((URLRequest) throws -> Void)? = nil) {
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
        guard let competion = serverConfirmation else { return }
        try? competion(request)
    }
}
