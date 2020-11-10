import Foundation

extension TableViewController {
    func updater(_ count: Int = 20) {
        _navigationBarRightActivityIndicator(hide: false)
        updaterGroup.enter()
        updaterQueue.async(group: updaterGroup, execute: {
            API.loadRandomUsers(count)
        })
        updaterGroup.notify(queue: .main, execute: { [self] in
            defer { tableView.reloadData() }
            _navigationBarRightActivityIndicator(hide: true)
        })
    }
}
