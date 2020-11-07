import CoreData

protocol Coredata {
    func saveObject<T:NSManagedObject>(_ appDelegate: AppDelegate, _ entity: T.Type, _ context: NSManagedObjectContext, _ key: String, _ value: Any)
    func getCoreData<T>(_ appDelegate: AppDelegate, _: T.Type, output: (([T]) -> Void)?) where T : NSManagedObject
}
