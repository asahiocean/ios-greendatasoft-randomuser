import Foundation

extension POST {
    public func contentType(_ method: RequestMethod = .POST, _ customRequest: URLRequest? = nil, url: String, param: [String:Any], callback: @escaping (URLRequest) throws -> Void?) {
        guard let url = URL(string: url.urlValid) else { return }
        var request = customRequest ?? URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        request.httpBody = param.percentEncoded()
        try? callback(request)
    }
}
