import Foundation
import UIKit.UIApplication
import CoreData.NSManagedObject
import CoreData.NSManagedObjectContext

extension Coredata {
    public dynamic func saveObject<T:NSManagedObject>(_ appDelegate: AppDelegate, _ : T.Type, _ context: NSManagedObjectContext, _ key: String, _ value: Any) {
        DispatchQueue.main.async {
            let object = T.init(context: context)
            object.setValue(value, forKey: key)
            appDelegate.saveContext(); #warning("OK")
        }
    }
}
