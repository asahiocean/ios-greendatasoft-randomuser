import Foundation
import UIKit.UINib

extension TableViewController {
    internal func _start() {
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "\(type(of: self))._start")
        group.enter()
        queue.async(group: group, qos: .background, execute: { [self] in
            // 
            group.leave()
        })
        group.enter()
        queue.async(group: group, qos: .background, execute: { [self] in
            needUpdates = true
            group.leave()
        })
        group.notify(queue: .main, execute: { [self] in
            tableView.register(UINib(nibName: cellnibName, bundle: bundleCell), forCellReuseIdentifier: cellIdentifier)
            // чтобы выиграть время на загрузку новых пользователей при попытке быстрого скроллинга
            tableView.decelerationRate = .fast // smooth scrolling
//            tableView.frame = view.frame
//            tableView.translatesAutoresizingMaskIntoConstraints = false
//            tableView.clipsToBounds = true
//            tableView.setNeedsDisplay()
//            tableView.layoutIfNeeded()
            tableView.separatorStyle = .none
            tableView.delegate = self
            tableView.dataSource = self
            tableView.reloadData()
        })
    }
}
