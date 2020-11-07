import UIKit
import CoreData
import EGOCache

final class StorageManager: DatabaseWorker, Coredata {

    public static var shared = StorageManager()
    fileprivate(set) public var appDelegate: AppDelegate!
    fileprivate(set) public var viewContext: NSManagedObjectContext!
    fileprivate(set) var setQueue: DispatchQueue!
    fileprivate(set) var setGroup: DispatchGroup!
    
    public let cache: EGOCache = EGOCache.global()
    internal(set) public dynamic var database: Database?
        
    func setdb(results: [Results], info: Info) {
        setGroup.enter()
        setQueue.async(group: setGroup, execute: { [self] in
        switch database {
        case nil:
            database = Database(results: results, info: info)
            setGroup.leave()
        default:
            database?.results.append(contentsOf: results)
            setGroup.leave()
        }
        })
        setGroup.notify(queue: .main, execute: { [self] in
        guard let jsonData = try? database?.jsonData() else { return }
        saveObject(appDelegate, JsondataEntity.self, viewContext, "jsonData", jsonData)
        cache.setData(jsonData, forKey: "jsonData", withTimeoutInterval: 2592000) // 2592000 sec == 1 month
        })
    }
    
    static func getdb(_ completion: @escaping InfRes) {
        guard let db = StorageManager().database else { return }
        completion(db.results, db.info)
    }
    
    static func statusdb(_ status: Status, state: @escaping State) {
        guard let db = StorageManager().database else { return }
        switch status {
            case .count:
                state(db.results.count)
            break
            // default: break
        }
    }
    
//    dynamic func handlerData(_ data: Data) {
//        self.egoCache(data)
//        self.coreData(data)
//    }
    
    private init() {
        self.setQueue = DispatchQueue(label: "com.StorageManager.setQueue.queue")
        self.setGroup = DispatchGroup()
        DispatchQueue.main.async {
            guard let delegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate), let context = try? delegate.persistentContainer.viewContext else { fatalError("ERROR") }
            self.appDelegate = delegate
            self.viewContext = context
        }
    }
}
