import Foundation

/// Допустим, что нужно отправить на сервер отчет о количестве полученных данных
final class POST {
    static let shared = POST()
    
    func request(data: Data?) {
        DispatchQueue(label: "POSTRequest.utility.async", qos: .utility).async {
            var request: URLRequest!
            var parameters: [String:Any] = [:]
            
            guard let url = URL(string: URLs.post) else { return }
            request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = MethodRequest.POST.rawValue
            
            let datacount = data?.count ?? 0
            parameters.updateValue(datacount, forKey: "datacount")
            request.httpBody = parameters.percentEncoded()
            
            URLSession.shared.dataTask(with: request) { data, _, _ in
                if let data = data {
                    // ответ сервера о получении
                    if let answer = String(data: data, encoding: .utf8) {
                        print(answer)
                    }
                }
            }.resume()
        }
    }
    
    private init() {
        
    }
}
