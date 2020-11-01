import UIKit

extension UIAlertController {
    @objc private func _dis() { dismiss(animated:true, completion:nil)}

    func exitIntuitive(vc: UIViewController) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(_dis))
        view.superview?.subviews[0].addGestureRecognizer(tapGesture)
    }
}
