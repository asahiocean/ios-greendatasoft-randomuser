import Foundation

extension GET {
    static func dataLoader(_ method: Method, _ url: String, _ completion: @escaping (Data?) throws -> Void?) {
        DispatchQueue(label: "GET.dataLoader.utility.queue", qos: .utility).async {
            // Валидация url
            guard let url = URL(string: url.urlValid)
            else {
                try? completion(nil)
                return }
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let status = (response as? HTTPURLResponse)?.statusCode {
                    print("Status request - \(status)")
                    switch status {
                        case (200...299):
                            if let data = data {
                                do {
                                    try completion(data)
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        // fallthrough // принудительно "проваливается" к следующему кейсу
                    default:
                        break
                    }
                }
            }.resume()
        }
    }
}
