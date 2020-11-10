import Foundation
import Dispatch
import UIKit.UIContextMenuInteraction

extension UserinfoVC {
    internal func _photoSetup(_ result: Results) {
        API.loadImage(result.picture.largeUrl, { [self] image -> Void in
            DispatchQueue.main.async {
                photo.image = image
            }
        })
        DispatchQueue.main.async { [self] in
            bgGradientPhoto.backgroundColor = UIColor(patternImage: photo.image ?? UIImage(named: "RoyalBlueGradient")!)
            photo.layer.cornerRadius = photo.bounds.width/2
        }
        // Context Menu Interaction
        photo.isUserInteractionEnabled = true
        interactionPhoto = UIContextMenuInteraction(delegate: self)
        photo.addInteraction(interactionPhoto)
    }
}
