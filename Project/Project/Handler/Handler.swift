import Foundation

final class Handler: APIData, JSON {
    var jsonDecoder: JSONDecoder!

    public static let shared = Handler()
    
    func apidata(_ data: Data?) {
        if let data = data {
            jsonHandler(data)
        } else {
            let cache = StorageManager.shared.cache
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
