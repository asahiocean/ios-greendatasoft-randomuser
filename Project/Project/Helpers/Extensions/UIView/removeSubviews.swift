import UIKit.UIView

extension UIView {
    func removeSubviews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
}
