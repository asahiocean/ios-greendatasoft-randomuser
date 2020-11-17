import UIKit
import CoreData
import EGOCache
import Network

final class StorageManager: DatabaseWorker, Coredata {
    
    public static var shared = StorageManager()
    fileprivate(set) public var appDelegate: AppDelegate!
    fileprivate(set) public var viewContext: NSManagedObjectContext!

    let quene = DispatchQueue(label: "com.StorageManager.setdb")
    let group = DispatchGroup()
    
    public let cache: EGOCache = EGOCache.global()
    internal(set) public var database: Database?
    
    func setdb(_ results: [Result], _ info: Info) {
        group.enter()
        quene.async(group: group, execute: { [self] in
            switch database {
            case nil:
                database = Database(results: results, info: info)
                do { group.leave() }
            default:
                database?.results.append(contentsOf: results)
                do { group.leave() }
            }
        })
        group.notify(queue: .main, execute: { [self] in
            defer { updaterGroup.leave() }
            
            let queueMonitor = DispatchQueue(label: "com.monitor.queue")
            let monitor = NWPathMonitor()
            monitor.start(queue: queueMonitor)
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: { [self] in
                        if let db = database, let data = try? db.jsonData() {
                            saveObject(appDelegate, JsondataEntity.self, viewContext, keyJsonData, data)
                            cache.setData(data, forKey: keyJsonData, withTimeoutInterval: 2592000) // 1 month
                            API.report(key: "results", value: db.results.count)
                        }
                    })
                } else {
                    defer { updaterGroup.resume() }
                    print("[🛑]: \(type(of: self)): data from cache!")
                }
            }
        })
    }
    
    func getdb(_ completion: @escaping InfRes) {
        guard let db: Database = database else { return }
        completion(db.results, db.info)
    }
    
    func statusdb(_ status: Status, state: @escaping State) {
        guard let db = StorageManager().database else { return }
        switch status {
            case .count:
                state(db.results.count)
            break
                // default: break
        }
    }
    
    private init() {
        DispatchQueue.main.async { [self] in
            guard let delegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate), let context = try? delegate.persistentContainer.viewContext else { fatalError("> AppDelegate <") }
            appDelegate = delegate
            viewContext = context
        }
    }
}
