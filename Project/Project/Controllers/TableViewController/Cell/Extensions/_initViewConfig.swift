import Foundation

extension CustomCell {
    internal func _initViewConfig() {
        DispatchQueue.main.async { [self] in
            layer.borderWidth = 0.5
            layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            autoresizingMask =
                [.flexibleWidth, .flexibleHeight]
        }
    }
}
