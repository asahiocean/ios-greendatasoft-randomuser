import Foundation

extension TableViewController {
    func updater() {
        guard needUpdates == true else { return }
        _navigationBarRightActivityIndicator(hide: false)
        updaterGroup.enter()
        updaterQueue.async(group: updaterGroup, execute: {
            API.loadRandomUsers(20)
        })
        updaterGroup.notify(queue: .main, execute: { [self] in
            needUpdates = false
            tableView.reloadData()
            _navigationBarRightActivityIndicator(hide: true)
        })
    }
}
