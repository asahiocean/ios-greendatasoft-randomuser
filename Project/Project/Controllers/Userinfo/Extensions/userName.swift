import Foundation
import UIKit.UIContextMenuInteraction

extension UserinfoVC {
    internal func userName(_ result: Result) {
        if let firstname = result.name.first,
           let lastname = result.name.last {
            defer { fullname.text = firstname + " " + lastname }
            
            fullname.isUserInteractionEnabled = true
            interactionName = UIContextMenuInteraction(delegate: self)
            fullname.addInteraction(interactionName)
        }
    }
}
