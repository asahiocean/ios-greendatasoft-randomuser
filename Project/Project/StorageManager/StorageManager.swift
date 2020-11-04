import UIKit
import CoreData
import EGOCache

final class StorageManager: Coredata, DatabaseWorker {
    
    public static var shared = StorageManager()
    internal var appDelegate: AppDelegate!
    internal var viewContext: NSManagedObjectContext!
    
    public let cache: EGOCache = EGOCache.global()
    fileprivate(set) public dynamic var database: Database? {
        didSet {
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.15, execute: {
                self.setGroup.leave()
            })
        }
    }
    
    dynamic func statusDatabase(_ status: Status, state: @escaping State) {
        switch status {
            case .count:
                state(database?.results.count ?? 0)
            break
            // default: break
        }
    }

    private let setQueue = DispatchQueue(label: "com.StorageManager.setQueue")
    private let setGroup = DispatchGroup()
    public func setDatabase(_ db: Database) {
        setGroup.enter()
        setQueue.async(group: setGroup, execute: { [self] in
            switch database {
            case nil:
                database = db
            default:
                database?.results.append(contentsOf: db.results)
            }
        })
        setGroup.notify(qos: .background, flags: .barrier, queue: setQueue, execute: {
            jsonHandlerGroup.leave()
            updaterGroup.leave()
        })
    }
    
    public dynamic func getDatabase(_ result: @escaping DBV) {
        guard let db = self.database else { return }
        result(db)
    }
        
    dynamic func handlerData(_ data: Data) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, qos: .background, execute: {
            self.egoCache(data)
            self.coreData(data)
        })
    }
        
    private init() {
        DispatchQueue.main.async {
            guard let delegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate), let context = try? delegate.persistentContainer.viewContext else { fatalError() }
            self.appDelegate = delegate
            self.viewContext = context
        }
    }
}
