import Foundation

extension POST {
    static func contentType(_ method: Method = .POST, _ customRequest: URLRequest? = nil, url: String, param: [String:Any], callback: @escaping (URLRequest) throws -> Void?) {
        DispatchQueue(label: "POST.autoRequest.utility.queue", qos:.utility).async {
            guard let url = URL(string: url.urlValid) else { return }
            var request = customRequest ?? URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = method.rawValue
            request.httpBody = param.percentEncoded()
            try? callback(request)
        }
    }
}
