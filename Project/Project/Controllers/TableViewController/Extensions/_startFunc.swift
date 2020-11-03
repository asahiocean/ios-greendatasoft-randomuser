import Foundation
import UIKit.UITableView

extension TableViewController {
    internal func _start() {
        DispatchQueue.main.async { [self] in
            // чтобы выиграть время на загрузку новых пользователей при попытке быстрого скроллинга
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
            DispatchQueue.global(qos: .background).async { [self] in
                if let results = StorageManager.shared.database?.results.count {
                    needUpdates = (results > 0)
                    cellsNumber = results
                }
            }
        }
    }
}
