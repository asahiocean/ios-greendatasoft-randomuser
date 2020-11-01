import UIKit.UIApplication

extension NotebookVC {
    func _appDelegate() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
}
