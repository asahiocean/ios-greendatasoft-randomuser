import UIKit
import CoreData
import EGOCache

protocol Coredata {
    func saveObject<T:NSManagedObject>(_ appDelegate: AppDelegate, _ entity: T.Type, _ context: NSManagedObjectContext, _ key: String, _ value: Any)
    func getCoreData<T>(_ appDelegate: AppDelegate, _: T.Type, output: (([T]) -> Void)?) where T : NSManagedObject
}

final class StorageManager: SetData, DatabaseWorker {

    public static var shared = StorageManager()
    internal(set) public var appDelegate: AppDelegate!
    internal(set) public var viewContext: NSManagedObjectContext!
    
    public let cache: EGOCache = EGOCache.global()
    internal(set) public dynamic var database: Database?

    func setdb(results: [Results], info: Info) {
        let queue = DispatchQueue(label: "updater.queue")
        let group = DispatchGroup()
        
        group.enter()
        queue.async(group: group, execute: { [self] in
        switch database {
        case nil:
            database = Database(results: results, info: info)
        default:
            database?.results.append(contentsOf: results)
        }
        group.leave()
        })
        group.notify(queue: .main, execute: {
            
        })
    }
    
    func setdata(_ data: Data?) {
        if let data = data {
            func saveObject<T:NSManagedObject>(_ appDelegate: AppDelegate, _ entity: T.Type, _ context: NSManagedObjectContext, _ key: String, _ value: Any) {
                DispatchQueue.main.async {
                    let object = entity.init(context: context)
                    object.setValue(value, forKey: key)
                    appDelegate.saveContext()
                }
            }
            
            DispatchQueue.main.async {
                saveObject(self.appDelegate, JsondataEntity.self, self.viewContext, "jsondata", data)
            }
        }
    }
    
    func getCoreData<T>(_ appDelegate: AppDelegate, _: T.Type, output: (([T]) -> Void)?) where T : NSManagedObject{
        guard let request = T.fetchRequest() as? NSFetchRequest<T> else { return }
        request.returnsObjectsAsFaults = false
        let asyncRequest = NSAsynchronousFetchRequest(fetchRequest: request) { rawdata in
            guard let result = rawdata.finalResult, let export = output else { return }
            export(result)
        }
        do {
            try appDelegate.persistentContainer.viewContext.execute(asyncRequest)
        } catch {
            
        }
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
        DispatchQueue.main.async {
            guard let delegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate), let context = try? delegate.persistentContainer.viewContext else { fatalError() }
            self.appDelegate = delegate
            self.viewContext = context
        }
    }
}
