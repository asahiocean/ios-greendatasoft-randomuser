import Foundation
import Dispatch

final class Handler {
    
    public static let shared = Handler()
    
    public var storage: StorageManager = StorageManager.shared
    
    public final func jsonData(_ data: Data, _ completion: ((Any)->())? = nil) {
        
        guard let db = try? JSONDecoder().decode(Database.self, from: data) else { return }
        let semaphore = DispatchSemaphore(value: 0)
        
        for i in db.results.indices {
            let urlStr: String = db.results[i].picture.largeUrl
            API.shared.loadImage(urlStr, { (image) -> Void in
                db.results[i].picture.image = image
                if i == db.results.endIndex - 1 { semaphore.signal() }
            })
        }
        
        semaphore.wait()
        self.storage.setdb(db)
    }
    
    public final func setdata(_ data: Data?) {
        guard let data = data else { getBackup(); return }
        jsonData(data)
    }
    
    fileprivate init() { }
}
extension Handler {
    func getBackup() {
        guard storage.database == nil else { return }
        
        if let keys = storage.cache.allKeys() as? [String], keys.isEmpty == false {
            for key in keys where key.hasPrefix(jsonDataKey) {
                guard let data = storage.cache.data(forKey: key) else { return }
                self.jsonData(data)
            }
        } else {
            storage.getCoreData(JsondataEntity.self, output: { array -> Void in
                guard let last = array.last, let data = last.jsonData else { return }
                self.jsonData(data)
            })
        }
    }
}
