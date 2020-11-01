import UIKit

extension NotebookVC {
    final internal dynamic func _storageManagerSetup() {
        if let delegate = (UIApplication.shared.delegate as? AppDelegate) {
            appDelegate = delegate
            context = appDelegate.persistentContainer.viewContext
        }
    }
}
