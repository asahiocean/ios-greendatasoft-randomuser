import Foundation
import Dispatch
import UIKit.UIContextMenuInteraction

extension UserinfoVC {
    internal func _photoSetup(_ result: Result) {
        API.loadImage(result.picture.largeUrl, { [self] image -> Void in
            DispatchQueue.main.async {
                photo.image = image
            }
        })
        DispatchQueue.main.async { [self] in
            bgGradientPhoto.backgroundColor = UIColor(patternImage: photo.image ?? UIImage(named: "RoyalBlueGradient")!)
            photo.layer.cornerRadius = photo.bounds.width/2
            photo.clipsToBounds = true
            photo.layer.masksToBounds = true
            photo.layer.borderColor = #colorLiteral(red: 0.2031390071, green: 0.2078698874, blue: 0.2164929211, alpha: 1)
            photo.layer.borderWidth = 5
        }
        // Context Menu Interaction
        photo.isUserInteractionEnabled = true
        interactionPhoto = UIContextMenuInteraction(delegate: self)
        photo.addInteraction(interactionPhoto)
    }
}
