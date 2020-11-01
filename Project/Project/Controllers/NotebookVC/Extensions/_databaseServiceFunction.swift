import UIKit

extension NotebookVC {
    final internal dynamic func _databaseServiceFunction() {
        DispatchQueue.main.async { [self] in
            _ = view.subviews.compactMap({$0 as? UITableView}).compactMap({$0.reloadData()})
        }
    }
}
