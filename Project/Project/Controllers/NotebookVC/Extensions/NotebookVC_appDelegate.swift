import UIKit

extension NotebookVC {
    var appDelegate: AppDelegate {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate  else { fatalError() }
        return delegate
   }
}
