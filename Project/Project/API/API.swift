import Foundation
import EGOCache
import CoreData

protocol ParserDelegate: class {
    func reception(data: Data)
}

struct API: GET, POST, EgoCache {
    
    static let shared = API()
        
    //MARK: EGOCache
    var cache: EGOCache!
    
    func get(method: RequestMethod, url: String, completion: @escaping (Data?) throws -> Void) {
        DispatchQueue(label: "API.get.utility.queue", qos:.utility).async {
            self.dataLoader(method, url, { data -> Void in
                try? completion(data)
            })
        }
    }
    
    func post(_ method: RequestMethod, _ url: String, _ parameters: [String : Any], completion: @escaping ((Data?) -> Void)) {
        DispatchQueue(label: "API.post.utility.queue", qos:.utility).async {
            self.contentType(url: url, param: parameters, callback: { request in
                self.answer(request: request, { data -> Void in
                    guard let data = data else { return }
                    completion(data)
                })
            })
        }
    }
    
    private init() {
        self.cache = EGOCache.global()
    }
}
