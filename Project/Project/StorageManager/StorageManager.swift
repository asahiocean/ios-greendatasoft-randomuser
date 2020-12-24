import UIKit
import CoreData
import EGOCache
import Network

final class StorageManager: DBWorker, Coredata {
    
    public static var shared = StorageManager()
    private(set) public var appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    private(set) public lazy var viewContext: NSManagedObjectContext = {
        return self.appDelegate.persistentContainer.viewContext
    }()
    
    public let cache: EGOCache = EGOCache.global()
    internal(set) public var database: Database?
    
    func setdb(_ db: Database) {
        let semaphore = DispatchSemaphore(value: 0)
        
        switch database {
        case nil:
            database = db
            semaphore.signal()
        default:
            database?.results.append(contentsOf: db.results)
            semaphore.signal()
        }
        
        semaphore.wait()
        defer { updaterGroup.leave() }
        
        let queueMonitor = DispatchQueue(label: "com.monitor.queue")
        let monitor = NWPathMonitor()
        
        monitor.start(queue: queueMonitor)
        monitor.pathUpdateHandler = { path in
            guard path.status == .satisfied else {
                defer { updaterGroup.resume() }
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: { [self] in
                if let db = database, let data = try? db.jsonData() {
                    saveObject(appDelegate, JsondataEntity.self, viewContext, jsonDataKey, data)
                    cache.setData(data, forKey: jsonDataKey, withTimeoutInterval: 2592000) // 1 month
                    API.shared.report(key: "results", value: db.results.count)
                }
            })
        }
    }
        
    func statusdb(_ status: Status, _ completion: @escaping StatusType) {
        guard let db = StorageManager().database else { return }
        switch status {
        case .count:
            completion(db.results.count)
        }
    }
}
