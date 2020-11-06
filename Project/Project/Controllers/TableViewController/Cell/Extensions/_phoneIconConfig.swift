import Foundation
import FontAwesome_swift

extension CustomCell {
    internal func _phoneIconConfig() {
        let wh = self.bounds.height / 8
        phoneIcon.image = .fontAwesomeIcon(
            name: .phoneAlt,
            style: .solid,
            textColor: #colorLiteral(red: 0.2030032575, green: 0.2080235779, blue: 0.2164820433, alpha: 1),
            size: CGSize(width: wh, height: wh))
    }
}
