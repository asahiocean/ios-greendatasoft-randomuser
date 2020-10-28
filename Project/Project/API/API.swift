import Foundation

protocol ParserDelegate: class {
    func reception(data: Data)
}

struct API: GET, POST {

    static let shared = API()
    
    func get(method: RequestMethod, url: String, completion: @escaping (Data?) -> Void) {
        DispatchQueue(label: "API.get.utility.queue", qos:.utility).async {
            self.dataLoader(method, url, { data -> Void in
                completion(data)
            })
        }
    }
    
    func post(_ method: RequestMethod, _ url: String, _ parameters: [String : Any], completion: @escaping ((Data?) -> Void)) {
        DispatchQueue(label: "API.post.utility.queue", qos:.utility).async {
            contentType(url: url, param: parameters, callback: { request in
                answer(request: request, { data -> Void in
                    guard let data = data else { return }
                    completion(data)
                })
            })
        }
    }
    
    private init() { }
}
