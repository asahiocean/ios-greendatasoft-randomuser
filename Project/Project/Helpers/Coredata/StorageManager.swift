import Foundation
import CoreData
import EGOCache

struct StorageManager {
    let cache: EGOCache = EGOCache.global()
    
    static let shared = StorageManager()
    
    dynamic func accept<T>(_ value: T) {
        switch value {
            case let data as Data:
                print("StorageManager_accept_data: ", data.count)
                StorageManager.shared.cache.setData(data, forKey: "jsondata\(Int(Date().timeIntervalSince1970))", withTimeoutInterval: 2592000) // 2592000 sec == 1 month
                DispatchQueue.main.async {
                    guard let delegate = NotebookVC().appDelegate, let context = NotebookVC().context else { return }
                    StorageManager.saveObject(delegate, JsonData.self, context, "jsondata", data)
                    print("StorageManager.saveObject: OK")
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
            print("🟢 sendFetchRequest.finalResult?.count: \(String(describing: rawdata.finalResult?.count))")
            guard let result = rawdata.finalResult, let export = output else { return }
            export(result)
        }
        do {
            try appDelegate.persistentContainer.viewContext.execute(asyncRequest)
        } catch let error as NSError {
            print("\(type(of: self)) GetObjectError:", error.localizedDescription)
        }
    }
    private init() {}
}
