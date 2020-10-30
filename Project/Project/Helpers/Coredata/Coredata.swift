import Foundation
import CoreData

protocol Coredata {
    func sendFetchRequest<T: NSManagedObject>(_ appDelegate: AppDelegate!, _ : T.Type, output: (([T]) -> Void)?)
    func saveContextEntity<T:NSManagedObject>(_ appDelegate: AppDelegate!, _ : T.Type, _ context: NSManagedObjectContext, _ key: String, _ value: Any)
}

extension Coredata {
    func saveContextEntity<T:NSManagedObject>(_ appDelegate: AppDelegate!, _ : T.Type, _ context: NSManagedObjectContext, _ key: String, _ value: Any) {
        DispatchQueue.main.async {
            let fetchRequest: NSManagedObject = T.init(context: context)
            fetchRequest.setValue(value, forKey: key)
            DispatchQueue.main.async {
                appDelegate.saveContext()
            }
        }
    }
    
    func sendFetchRequest<T: NSManagedObject>(_ appDelegate: AppDelegate!, _ : T.Type, output: (([T]) -> Void)? = nil) {
        guard let request = T.fetchRequest() as? NSFetchRequest<T> else { return }
        request.returnsObjectsAsFaults = false
        let asyncRequest = NSAsynchronousFetchRequest(fetchRequest: request) { rawdata in
            print("🟢 sendFetchRequest.finalResult?.count: \(String(describing: rawdata.finalResult?.count))")
            guard let result = rawdata.finalResult, let export = output else { return }
            export(result)
        }
        do {
            try appDelegate.persistentContainer.viewContext.execute(asyncRequest)
        } catch let error as NSError {
            print("\(type(of: self)) docatchError: ", error.localizedDescription)
        }
    }
}
