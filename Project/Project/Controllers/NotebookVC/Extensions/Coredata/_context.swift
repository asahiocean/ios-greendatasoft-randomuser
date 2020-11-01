import UIKit.UIApplication
import CoreData.NSManagedObject

extension NotebookVC {
    func _context() -> NSManagedObjectContext? {
        guard let context = _appDelegate()?.persistentContainer.viewContext
        else {
            return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        }
        return context
    }
}
