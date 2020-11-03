import Foundation

extension TableViewController {
    internal dynamic func _updater(_ indexPath: IndexPath) {
        if needUpdates {
            needUpdates = false
            print("\(type(of: self))._updater")
            // API.shared.loadRandomUsers(20)
            DispatchQueue.main.async { [self] in
                tableView.reloadData()
            }
        }
    }
}
