import Foundation
import UIKit.UINib

extension TableViewController {
    func didSelectRowAt_UserinfoVC(_ indexPath: IndexPath) {
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
