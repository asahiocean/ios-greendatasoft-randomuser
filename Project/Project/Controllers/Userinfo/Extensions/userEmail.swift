import UIKit

extension UserinfoVC {
    public func userEmail(_ result: Result) {
        defer { email.text = result.email }
        
        // Context Menu Interaction
        email.isUserInteractionEnabled = true
        interaction_Email = UIContextMenuInteraction(delegate: self)
        email.addInteraction(interaction_Email)
    }
}
