import UIKit

extension UIAlertController {
    @objc fileprivate func dismissAlertController() {
        self.dismiss(animated: true, completion: nil)
    }

    func exitIntuitive(vc: UIViewController) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
        self.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
    }
}
