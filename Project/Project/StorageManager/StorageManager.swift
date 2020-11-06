import UIKit
import CoreData
import EGOCache

final class StorageManager: Coredata, DatabaseWorker {
    
    public static var shared = StorageManager()
    internal var appDelegate: AppDelegate!
    internal var viewContext: NSManagedObjectContext!
    
    public let cache: EGOCache = EGOCache.global()
    internal(set) public dynamic var database: Database? {
        didSet {
            // print(try? database?.jsonData().count ?? 0)
        }
    }

    func setdb(results: [Results], info: Info) {
        switch database {
        case nil:
            database = Database.init(results: results, info: info)
        default:
            database?.results.append(contentsOf: results)
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
    
    dynamic func handlerData(_ data: Data) {
        self.egoCache(data)
        self.coreData(data)
    }
        
    private init() {
        DispatchQueue.main.async {
            guard let delegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate), let context = try? delegate.persistentContainer.viewContext else { fatalError() }
            self.appDelegate = delegate
            self.viewContext = context
        }
    }
}
