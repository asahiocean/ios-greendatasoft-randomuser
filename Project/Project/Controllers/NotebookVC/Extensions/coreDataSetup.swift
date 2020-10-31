import UIKit

extension NotebookVC {
    func storageManagerSetup() {
        if let delegate = (UIApplication.shared.delegate as? AppDelegate) {
            appDelegate = delegate
            context = appDelegate.persistentContainer.viewContext
            storage = StorageManager.shared
        }
    }
}
