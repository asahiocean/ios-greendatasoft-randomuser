import Foundation
import UIKit.UIApplication
import CoreData.NSManagedObject
import CoreData.NSManagedObjectContext

protocol Coredata {
    dynamic func getCoreData<T: NSManagedObject>(_ appDelegate: AppDelegate, _ : T.Type, output: (([T]) -> Void)?)
    dynamic func saveObject<T:NSManagedObject>(_ appDelegate: AppDelegate, _ : T.Type, _ context: NSManagedObjectContext, _ key: String, _ value: Any)
}
