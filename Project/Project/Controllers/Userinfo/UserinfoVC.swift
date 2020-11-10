import UIKit
import SimpleImageViewer

class UserinfoVC: UIViewController {
    
    static var nibName: String { String(describing: self ) }
    
    @IBOutlet weak var bgGradientPhoto: UIView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var locationIcon: UIImageView!
    
    var interactionMap: UIContextMenuInteraction!
    var interactionPhoto: UIContextMenuInteraction!
    private var address: Location?
    
    public func setUserInfo(_ result: Results) {
        DispatchQueue.main.async {
            API.loadImage(result.picture.largeUrl, { image in
                self.photo.image = image
            })
        }
        firstname.text = result.name.first
        surname.text = result.name.last
        email.text = result.email
        address = result.location
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "User info"
        _locationIconConfig()
        
        self.interactionPhoto = UIContextMenuInteraction(delegate: self)
        photo.addInteraction(interactionPhoto)
        
        photo.layer.cornerRadius = photo.bounds.width/2
        
//        let configuration = ImageViewerConfiguration { config in
//            config.imageView = photo
//        }
//        let imageViewerController = ImageViewerController(configuration: configuration)
//        present(imageViewerController, animated: true)
    }
    

}

extension UserinfoVC: UIContextMenuInteractionDelegate {

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        switch interaction {
        case interactionMap:
            func contextMenu() -> UIMenu {
                let copy = UIAction(title: "Копировать адрес", image: UIImage(systemName: "doc.text", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)) { action in
                    print("Копировать адрес")
                }
                
                let map = UIAction(title: "Перейти в Карты", image: UIImage(systemName: "map", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)) { action in
                    print("Перейти в Карты")
                }
                return UIMenu(title: "", children: [map, copy])
            }

            if let map = UINib(nibName: MapsViewController.nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? MapsViewController {
                
                if let pin = self.address { map.pinPreview(pin) }
                
                let config = UIContextMenuConfiguration(
                    identifier: nil,
                    previewProvider: { () -> UIViewController? in
                    return map
                }) { _ -> UIMenu? in
                    return contextMenu()
                }
                return config
            }
        default:
            return nil
        }
        return nil
    }
}
