import Foundation
import UIKit.UITableView
import UIKit.UITableViewCell

extension TableViewController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let count = storage.database?.results.count,
           indexPath.row == (count - 5) { updater(15) }
    }
}
