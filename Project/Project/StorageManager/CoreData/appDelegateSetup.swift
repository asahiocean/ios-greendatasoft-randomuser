import UIKit.UIApplication
import CoreData

extension StorageManager {
    public static var appDelegate: AppDelegate! = {
        guard let delegate = (UIApplication.shared.delegate as? AppDelegate) else { fatalError() }
        return delegate
        // DispatchQueue.main.async { }
    }()

    public static var viewContext: NSManagedObjectContext = {
        guard let delegate = appDelegate?.persistentContainer.viewContext else { return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext }
        return delegate
        // DispatchQueue.main.async { }
    }()
}
