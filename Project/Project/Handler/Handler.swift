import Foundation

final class Handler: SetData, JSON {
    internal var jsonDecoder: JSONDecoder!
    private let storage: StorageManager = StorageManager.shared

    public static let shared = Handler()
    
    func setdata(_ data: Data?) {
        if let data = data {
            DispatchQueue.main.async { [self] in
            if let db = try? jsonDecoder.decode(Database.self, from: data) {
                storage.setdb(results: db.results, info: db.info)
            }}
        } else {
            let allKeys = storage.cache.allKeys()
            print(allKeys)
            
//            if let keys = cache.allKeys() as? [String] {
//                let items = keys.prefix("jsondata").sorted()
//                for item in items {
//                    if let cachedata = cache.data(forKey: item) {
//                        // self.jsonHandler(cachedata)
//                        sleep(1)
//                        print(cachedata.count)
//                    }
//                }
//            }
        }
    }
    private init() { }
}
