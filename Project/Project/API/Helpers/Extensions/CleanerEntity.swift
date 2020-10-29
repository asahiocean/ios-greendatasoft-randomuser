import Foundation
import CoreData

extension NotebookVC {
    func cleanerEntity(entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let objects = try context.fetch(fetchRequest)
            for object in objects as! [NSManagedObject] {
                context.delete(object)
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print("Fail Delete:", error.localizedDescription)
        }
    }
}
