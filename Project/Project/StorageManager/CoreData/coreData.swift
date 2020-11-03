import UIKit
import CoreData

extension StorageManager {
    public func coreData(_ data: Data) {
        saveObject(StorageManager.appDelegate, JsonData.self, StorageManager.viewContext, "jsondata", data)
    }        
}
