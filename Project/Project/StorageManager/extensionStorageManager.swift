import CoreData

extension StorageManager {
    func saveObject<T:NSManagedObject>(_ appDelegate: AppDelegate, _ entity: T.Type, _ context: NSManagedObjectContext, _ key: String, _ value: Any) {
        let object = entity.init(context: context)
        object.setValue(value, forKey: key)
        appDelegate.saveContext()
    }
    
    func getCoreData<T>(_: T.Type, output: (([T]) -> Void)?) where T : NSManagedObject {
        guard let request = T.fetchRequest() as? NSFetchRequest<T> else { return }
        request.returnsObjectsAsFaults = false
        let asyncRequest = NSAsynchronousFetchRequest(fetchRequest: request) { rawdata in
            guard let result = rawdata.finalResult, let export = output else { return }
            export(result)
        }
        do {
            try self.appDelegate.persistentContainer.viewContext.execute(asyncRequest)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
