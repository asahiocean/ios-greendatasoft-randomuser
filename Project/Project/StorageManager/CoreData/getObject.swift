import CoreData

extension StorageManager {
    func getDatabase<T>(_ appDelegate: AppDelegate, _: T.Type, output: (([T]) -> Void)?) where T : NSManagedObject {
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
}
