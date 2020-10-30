import Foundation

extension GET {
    public func dataLoader(_ method: RequestMethod, _ url: String, _ completion: @escaping (Data?) throws -> Void?) {
        DispatchQueue(label: "GET.dataLoader.utility.queue", qos: .utility).async {
            guard let url = URL(string: url.urlValid) else { try? completion(nil); return }
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let status = (response as? HTTPURLResponse)?.statusCode {
                    print("Status request - \(status)")
                    switch status {
                        case (200...299):
                            if let data = data {
                                print("\(type(of: self)) data: ", data.count)
                                do {
                                    try completion(data)
                                } catch let error as NSError {
                                    print("\(type(of: self)) docatchError: ", error.localizedDescription)
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
