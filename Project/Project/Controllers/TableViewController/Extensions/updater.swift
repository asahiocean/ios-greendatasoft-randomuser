import Foundation

extension TableViewController {
    func updater() {
        guard needUpdates == true else { return }
        _navigationBarRightActivityIndicator(hide: false)
        updaterGroup.enter()
        updaterQueue.async(group: updaterGroup, qos: .background, execute: {
            API.loadRandomUsers(20)
        })
        updaterGroup.notify(queue: .main, execute: { [self] in
            tableView.reloadData()
            needUpdates = false
            _navigationBarRightActivityIndicator(hide: true)
        })
    }
}
