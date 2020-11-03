import UIKit

extension TableViewController {
    @objc fileprivate func actionRight() {
        print("action()")
    }
    
    func _navigationBarRightButton(size: CGSize, textColor: UIColor?) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            image: UIImage.fontAwesomeIcon(
//                name: .git,
//                style: .solid,
//                textColor: textColor ?? .white,
//                size: size),
//            style: .plain,
//            target: self,
//            action: #selector(action)
    )}
}
