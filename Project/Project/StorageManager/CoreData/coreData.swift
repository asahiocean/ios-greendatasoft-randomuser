import UIKit
import CoreData

extension StorageManager {
    public func coreData(_ data: Data) {
        saveObject(StorageManager.appDelegate, JsonData.self, StorageManager.viewContext, "jsondata", data)
    }
        
    fileprivate func saveObject<T:NSManagedObject>(_ appDelegate: AppDelegate, _ : T.Type, _ context: NSManagedObjectContext, _ key: String, _ value: Any) {
        DispatchQueue.main.async {
            let (k,v) = (key,value)
            let object = T.init(context: context)
            object.setValue(v, forKey: k)
            appDelegate.saveContext()
        }
    }
}
