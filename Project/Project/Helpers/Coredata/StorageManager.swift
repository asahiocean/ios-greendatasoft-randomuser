import Foundation
import CoreData
import EGOCache

final class StorageManager {
    
    let cache: EGOCache = EGOCache.global()
    let timestamp = Int(Date().timeIntervalSince1970)

    static let shared: StorageManager = {
        let instance = StorageManager()
        return instance
    }()
    
    func accept<T>(_ value: T) {
        switch value {
        case let data as Data:
            print("-> \(type(of: self)): as Data", data.count)
            StorageManager.shared.cache.setData(data, forKey: "jsondata\(timestamp)", withTimeoutInterval: 2592000) // 2592000 sec == 1 month
            DispatchQueue.main.async {
                guard let delegate = NotebookVC().appDelegate, let context = NotebookVC().context else { return }
                StorageManager.shared.saveObject(delegate, JsonData.self, context, "jsondata", data)
            }
            print("-> StorageManager: SAVED!")
        default:
            break
        }
    }
    
    /// CoreData
    func saveObject<T:NSManagedObject>(_ appDelegate: AppDelegate, _ : T.Type, _ context: NSManagedObjectContext, _ key: String, _ value: Any) {
        DispatchQueue.main.async {
            let fetchRequest: NSManagedObject = T.init(context: context)
            fetchRequest.setValue(value, forKey: key)
            DispatchQueue.main.async {
                appDelegate.saveContext()
            }
        }
    }
    
    /// CoreData
    func getObject<T: NSManagedObject>(_ appDelegate: AppDelegate, _ : T.Type, output: (([T]) -> Void)? = nil) {
        guard let request = T.fetchRequest() as? NSFetchRequest<T> else { return }
        request.returnsObjectsAsFaults = false
        let asyncRequest = NSAsynchronousFetchRequest(fetchRequest: request) { rawdata in
            print("🟢 sendFetchRequest.finalResult?.count: \(String(describing: rawdata.finalResult?.count))")
            guard let result = rawdata.finalResult, let export = output else { return }
            export(result)
        }
        do {
            try appDelegate.persistentContainer.viewContext.execute(asyncRequest)
        } catch let CoredataError as NSError {
            print("\(type(of: self)) CoredataError:", CoredataError.localizedDescription)
        }
    }
    
    private init() {}
}

extension StorageManager: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
