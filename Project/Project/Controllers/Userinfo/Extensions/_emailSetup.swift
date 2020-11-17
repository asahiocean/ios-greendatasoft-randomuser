import Foundation
import UIKit.UIContextMenuInteraction

extension UserinfoVC {
    internal func _emailSetup(_ result: Result) {
        defer { email.text = result.email }
        
        // Context Menu Interaction
        email.isUserInteractionEnabled = true
        interactionEmail = UIContextMenuInteraction(delegate: self)
        email.addInteraction(interactionEmail)
    }
}
