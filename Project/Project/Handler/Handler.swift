import Foundation

final class Handler: SetData, JSON {
    static var jsonDecoder: JSONDecoder!
    internal let storage: StorageManager = StorageManager.shared

    public static let shared = Handler()
    
    func setdata(_ data: Data?) {
        if let data = data {
            jsonHandler(data)
        } else {
            let cache = storage.cache
            if let keys = cache.allKeys() as? [String] {
                let items = keys.prefix("jsondata").sorted()
                for item in items {
                    if let cachedata = cache.data(forKey: item) {
                        // self.jsonHandler(cachedata)
                        sleep(1)
                        print(cachedata.count)
                    }
                }
            }
        }
    }
    private init() { }
}
