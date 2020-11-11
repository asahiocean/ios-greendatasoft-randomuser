import Foundation
import UIKit.UITableView

extension TableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectRowAt_UserinfoVC(indexPath)
    }
}
