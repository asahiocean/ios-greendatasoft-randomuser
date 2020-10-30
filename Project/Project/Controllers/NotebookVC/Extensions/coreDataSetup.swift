import UIKit

extension NotebookVC {
    func coreDataSetup() {
        if let delegate = (UIApplication.shared.delegate as? AppDelegate) {
            self.appDelegate = delegate
            context = appDelegate.persistentContainer.viewContext
            coredata = Coredata.shared
        }
    }
}
