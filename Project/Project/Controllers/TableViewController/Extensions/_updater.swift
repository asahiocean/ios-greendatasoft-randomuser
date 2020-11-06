import Foundation

extension TableViewController {
    func _updater() {
        _navigationBarRightActivityIndicator(hide: false)
        updaterGroup.enter()
        updaterQueue.async(group: updaterGroup, qos: .background, execute: {
            API.loadRandomUsers(20)
        })
        updaterGroup.notify(queue: .main, execute: { [self] in
            tableView.reloadData()
            _navigationBarRightActivityIndicator(hide: true)
        })
    }
}
