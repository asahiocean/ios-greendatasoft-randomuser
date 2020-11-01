import Foundation
import EGOCache
import CoreData

struct API: GET, POST {    
    
    static let shared = API()
    
    dynamic func loadRandomuser(_ completion: @escaping (Database) throws -> Void) {
        self.get(.dataTask, URLRequest(url: URL(string: Url.get.rawValue.urlValid)!), { data -> Void in
            if let data = data {
                let d = JSONDecoder()
                d.keyDecodingStrategy = .convertFromSnakeCase
                d.dateDecodingStrategy = .iso8601
                StorageManager.shared.accept(data)
                try? completion(try d.decode(Database.self, from: data))
            }
        })
    }
    private init() { }
}
