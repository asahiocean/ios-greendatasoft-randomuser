import UIKit

extension TableViewController {
    //  @objc fileprivate func actionRight() { print("NavBarRightActInd") }
    
    func _navigationBarRightActivityIndicator(hide: Bool = false) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = #colorLiteral(red: 0.07864784449, green: 0.1034145281, blue: 0.1695130467, alpha: 0.8975010702)
        activityIndicator.startAnimating()
        let barButton = UIBarButtonItem(customView: activityIndicator)
        activityIndicator.isHidden = hide
        navigationItem.rightBarButtonItem = barButton
    }
}
