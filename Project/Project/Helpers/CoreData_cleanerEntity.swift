import Foundation
import CoreData

func cleanerEntity(entityName: String, context: NSManagedObjectContext) {
    // guard let context = NotebookVC().context else { return }
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    do {
        for object in try context.fetch(fetchRequest) as! [NSManagedObject] {
            context.delete(object)
        }
        do {
            try context.save()
        } catch let error as NSError {
            print("cleanerEntity_context_docatchError: ", error.localizedDescription)
        }
    } catch let error as NSError {
        print("cleanerEntity_Delete_docatchError: ", error.localizedDescription)
    }
}
