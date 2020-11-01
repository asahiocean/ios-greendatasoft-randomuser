import Foundation
import CoreData
import EGOCache

struct StorageManager {
    let cache: EGOCache = EGOCache.global()
    
    static let shared = StorageManager()
    
    dynamic func accept<T>(_ value: T) {
        switch value {
            case let data as Data:
                DispatchQueue.main.async {
                    StorageManager.shared.cache.setData(data, forKey: "jsondata\(Int(Date().timeIntervalSince1970))", withTimeoutInterval: 2592000) // 2592000 sec == 1 month
                    if let delegate = NotebookVC()._appDelegate(), let context = NotebookVC()._context() {
                        StorageManager.saveObject(delegate, JsonData.self, context, "jsondata", data)
                    }
                }
            default: break
        }
    }
    
    /// CoreData
    dynamic static func saveObject<T:NSManagedObject>(_ appDelegate: AppDelegate, _ : T.Type, _ context: NSManagedObjectContext, _ key: String, _ value: Any) {
        DispatchQueue.main.async {
            let fetchRequest: NSManagedObject = T.init(context: context)
            fetchRequest.setValue(value, forKey: key)
            DispatchQueue.main.async {
                appDelegate.saveContext()
            }
        }
    }
    
    /// CoreData
    dynamic static func getObject<T: NSManagedObject>(_ appDelegate: AppDelegate, _ : T.Type, output: (([T]) -> Void)? = nil) {
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
    private init() {}
}
