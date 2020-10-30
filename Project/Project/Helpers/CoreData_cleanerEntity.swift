import Foundation
import CoreData

func cleanerEntity(entityName: String, context: NSManagedObjectContext) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    do {
        for object in try context.fetch(fetchRequest) as! [NSManagedObject] {
            context.delete(object)
        }
        do {
            try context.save()
        } catch let cleanerEntity_context_error as NSError {
            print("🔴 cleanerEntity_context_error:", cleanerEntity_context_error.localizedDescription)
        }
    } catch let cleanerEntity_Delete_error as NSError {
        print("🔴 cleanerEntity_Delete_error:", cleanerEntity_Delete_error.localizedDescription)
    }
}
