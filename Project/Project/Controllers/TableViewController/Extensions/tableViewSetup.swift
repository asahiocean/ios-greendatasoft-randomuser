import Foundation
import UIKit.UIActivity

extension TableViewController {
    internal func tableViewSetup() {
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = rowHeight
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.decelerationRate = .fast
        tableView.contentInsetAdjustmentBehavior = .never
        
        let activityView = UIActivityIndicatorView(style: .large)
        tableView.backgroundView = activityView
        activityView.startAnimating()
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = (tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell) {
            if let res = storage.database?.results[indexPath.row] {
                cell.set(result: res)
            }
            return cell
        } else {
            let defaultCell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: CustomCell.identifier)
            defaultCell.backgroundColor = UIColor.systemRed
            return defaultCell
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let count = storage.database?.results.count,
           indexPath.row == (count - 5) { updater(15) }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let result = storage.database?.results[indexPath.row],
           let nav = navigationController {
            let name = UserinfoVC.nibName
            let bundle = Bundle(for: UserinfoVC.self)
            if let userinfo = UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil).first as? UserinfoVC {
                userinfo.setUserInfo(result)
                nav.pushViewController(userinfo, animated: true)
            }
        }
    }
}
