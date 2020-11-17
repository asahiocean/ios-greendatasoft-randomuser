import Foundation
import UIKit.UITableView

extension TableViewController {
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
