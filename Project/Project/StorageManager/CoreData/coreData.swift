import UIKit
import CoreData

extension StorageManager {
    public func coreData(_ data: Data) {
        DispatchQueue.main.async { [self] in
            saveObject(appDelegate, JsonData.self, viewContext, "jsondata", data); // #warning("OK")
        }
    }
}
