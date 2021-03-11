import Foundation

extension TableViewController {
    func updater(_ count: Int = 20) {
        _navigationBarRightActivityIndicator(hide: false)
        updaterGroup.enter()
        updaterQueue.async(group: updaterGroup, execute: {
            API.loadUsers(count)
        })
        updaterGroup.notify(queue: .main, execute: { [self] in
            tableView.reloadData()
            _navigationBarRightActivityIndicator(hide: true)
        })
    }
}
