import UIKit.UIView

extension UIView {
    public func removeSubviews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
}
