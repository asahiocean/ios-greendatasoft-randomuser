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
