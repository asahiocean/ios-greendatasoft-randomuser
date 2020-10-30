import Foundation
import EGOCache
import CoreData

struct API: GET, POST {
        
    static let shared = API()
        
    var cache: EGOCache! = EGOCache.global()
    
    func get(method: RequestMethod, url: String, completion: @escaping (Data?) throws -> Void) {
        DispatchQueue(label: "API.get.utility.queue", qos:.utility).async {
            self.dataLoader(method, url, { data -> Void in
                try? completion(data)
            })
        }
    }
    
    func post(_ method: RequestMethod, _ url: String, _ parameters: [String : Any], response: ((Data?) throws -> Void)? = nil) {
        DispatchQueue(label: "API.post.utility.queue", qos:.utility).async {
            self.contentType(url: url, param: parameters, callback: { request in
                self.answer(request: request, { data -> Void in
                    if let data = data {
                        if let answer = String(data: data, encoding: .utf8) {
                            print("✅ Server confirm: \(answer)")
                        }
                        guard let _return = response else { return }
                        try? _return(data)
                    } else {
                        print("🛑 Server confirm: ", String(describing: data?.count))
                        guard let _return = response else { return }
                        try? _return(data)
                    }
                })
            })
        }
    }
    
    private init() { }
}
