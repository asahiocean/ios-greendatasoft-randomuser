import Foundation
import UIKit.UIImage
import Nuke.Swift

extension CustomCell {
    internal func _imageViewPhotoConfig() {
        imageViewPhoto.clipsToBounds = true
        imageViewPhoto.layer.masksToBounds = true
                
        imageViewPhoto.layer.cornerRadius = imageViewPhoto.bounds.width / 2
                
        imageViewPhoto.layer.borderColor = #colorLiteral(red: 0.2031390071, green: 0.2078698874, blue: 0.2164929211, alpha: 1)
        imageViewPhoto.layer.borderWidth = 2
                
        if imageViewPhoto.image?.pngData() == nil {
        let storage = StorageManager.shared
        if let uuidStr = idpic?.uuidString, let imagedata = storage.cache.data(forKey: uuidStr) {
        self.imageViewPhoto.image = UIImage(data: imagedata); // #warning("Restore image from cache: OK")
        } else {
            let pipeline = ImagePipeline.shared
            for url in urlPackPhoto {
            pipeline.loadImage(with: URL(string: url)!,{ resp in
            switch resp {
            case let .success(result):
                self.imageViewPhoto.image = result.image
            default:
                break
            }})
            if imageViewPhoto.image?.pngData() != nil { break }
            }
        }}
    }
}
