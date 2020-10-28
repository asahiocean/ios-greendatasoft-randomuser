import Foundation

protocol ParserDelegate: class {
    func reception(data: Data)
}

final class API: GET, POST {
    static func post(_ method: Method, _ url: String, _ parameters: [String : Any]) {
        DispatchQueue(label: "API.post.utility.queue", qos:.utility).asyncAfter(deadline: .now() + 1, execute: {
            contentType(method, url: url, param: parameters, callback: { request in
                answer(request: request, { data -> Void in
                    guard let data = data, let answer = String(data: data, encoding: .utf8) else { return }
                    print("✅ Server confirm: \(answer)")
                })
            })
        })
    }
                
    static func get(method: Method, url: String, completion: @escaping (Data?) -> Void) {
        DispatchQueue(label: "API.get.utility.queue", qos:.utility).async {
            dataLoader(method, url, { data -> Void in
                completion(data)
            })
        }
    }
    
    private init() { }
}
