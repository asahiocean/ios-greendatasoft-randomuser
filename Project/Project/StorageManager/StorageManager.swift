import UIKit.UIApplication
import CoreData
import EGOCache


final class StorageManager: Coredata, DatabaseWorker {
    
    public static var shared = StorageManager()
    
    public let cache: EGOCache = EGOCache.global()
    fileprivate(set) public dynamic var database: Database? { didSet {
        print(database?.results.count)
    }}
    
    dynamic func statusDatabase(_ status: Status, result: @escaping StatusType){
        switch status {
            case .count:
                result(database?.results.count ?? 0)
                break
            // default: break
        }
    }

    public dynamic func setDatabase(_ db: Database) {
        if database == nil {
            database = db
        } else {
            for result in db.results {
                database?.results.append(result)
            }
        }
    }
    
    public dynamic func getDatabase(_ result: @escaping GetDB) {
        guard let db = database else { return }
        result(db)
    }
        
    dynamic func handlerData(_ data: Data) {
        let queue = DispatchQueue(label: "StorageManager.handlerData.datasaver.queue")
        let group = DispatchGroup()
        group.enter()
        queue.async(group: group, qos: .background, execute: {
            self.egoCache(data)
            group.leave()
        })
        group.notify(queue: .main, execute: {
            self.coreData(data)
        })
    }
    
    private init() { }
}
