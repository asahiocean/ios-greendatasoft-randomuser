import UIKit

extension UIAlertController {
    @objc private func _dismiss() { dismiss(animated:true, completion:nil)}

    func exitIntuitive(vc: UIViewController) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(_dismiss))
        view.superview?.subviews[0].addGestureRecognizer(tapGesture)
    }
}
