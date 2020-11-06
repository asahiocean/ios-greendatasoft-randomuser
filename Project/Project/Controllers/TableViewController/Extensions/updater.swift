import Foundation

extension TableViewController {
    func updater() {
        // guard needUpdates == true else { return }
        _navigationBarRightActivityIndicator(hide: false)
        API.loadRandomUsers(20)
        updaterGroup.notify(queue: .main, execute: { [self] in
            tableView.reloadData()
            _navigationBarRightActivityIndicator(hide: true)
        })
    }
}
