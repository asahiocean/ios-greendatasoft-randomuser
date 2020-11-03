import Foundation
import UIKit.UITableView

extension TableViewController {
    internal func startSession() {
        print("startSession: OK")
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "TableViewController.startSession")
        group.enter()
        queue.async(group: group, qos: .background, execute: {
            _ = group.wait(wallTimeout: .now() + 1)
            StorageManager.shared.getDatabase({ [self] db -> Void in
                localDatabase = db
                needUpdates = true
                group.leave()
            })
        })
        group.notify(queue: .main, execute: { [self] in
            tableView.reloadData()
            tableView.decelerationRate = .fast // smooth scrolling
            tableView.frame = view.frame
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.clipsToBounds = true
            tableView.setNeedsDisplay()
            tableView.layoutIfNeeded()
            tableView.separatorStyle = .none
            tableView.delegate = self
            tableView.dataSource = self
            tableView.reloadData()
        })
    }
}
