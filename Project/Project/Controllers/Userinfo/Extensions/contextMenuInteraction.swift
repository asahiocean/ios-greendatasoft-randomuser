import UIKit
import SimpleImageViewer

extension UserinfoVC: UIContextMenuInteractionDelegate {
    
    private static let icon_copy: UIImage! = {
        return UIImage(systemName: "doc.text", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
    }()
    
    private static let icon_map: UIImage! = {
        return UIImage(systemName: "map", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
    }()
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        var pasteBoardCopy: UIAction {
            return UIAction(title: "Копировать адрес", image: Self.icon_copy) { [weak self] action in
                
                pasteboard.string = self?.address
                
                if let location = try? self?.result?.location.jsonString() {
                    API.report(key: "Copied address", value: location)
                }
            }
        }
        var actionMenuMap: UIAction {
            return UIAction(title: "Перейти в Карты", image: Self.icon_map) { [weak self] (action) -> Void in
                if let coord = self?.location?.coordinates,
                   let lat = coord.latitude,
                   let lon = coord.longitude {
                    let url = URL(string: "https://maps.apple.com/?ll=\(lat),\(lon)")!
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
        
        switch interaction {
        case locationLabelInter:
            return UIContextMenuConfiguration(identifier: nil, previewProvider: { () -> UIViewController? in
                return nil
            }) { _ -> UIMenu? in
                return UIMenu(title: "", children: [pasteBoardCopy])
            }
        case mapIconInter:
            return UIContextMenuConfiguration(identifier: nil, previewProvider: { () -> UIViewController? in
                return nil
            }) { _ -> UIMenu? in
                return UIMenu(title: "", children: [actionMenuMap, pasteBoardCopy])
            }
        case userPhotoInter:
            let config = ImageViewerConfiguration { config in config.imageView = userPhotoImageView }
            let controller = ImageViewerController(configuration: config)
            present(controller, animated: true)
            
            if let url = result?.picture.largeUrl {
                API.report(key: "User opened photo", value: url)
            }
        case fullnameLabelInter:
            func contextMenu() -> UIMenu {
                let copy = UIAction(title: "Копировать", image: Self.icon_copy) { [weak self] action in
                    if let username = self?.fullnameLabel.text {
                        let pasteboard = UIPasteboard.general
                        pasteboard.string = username
                        API.report(key: "Username copied", value: username)
                    }
                }
                return UIMenu(title: "", children: [copy])
            }
            
            let config = UIContextMenuConfiguration(identifier: nil, previewProvider: { () -> UIViewController? in
                return nil
            }) { _ -> UIMenu? in
                return contextMenu()
            }
            return config
        case emailLabelInter:
            func contextMenu() -> UIMenu {
                let copy = UIAction(title: "Копировать", image: Self.icon_copy) { [weak self] action in
                    if let email = self?.emailLabel.text {
                        
                        pasteboard.string = email
                        API.report(key: "Email copied", value: email)
                    }
                }
                return UIMenu(title: "", children: [copy])
            }
            
            let config = UIContextMenuConfiguration(identifier: nil, previewProvider: { () -> UIViewController? in
                return nil
            }) { _ -> UIMenu? in
                return contextMenu()
            }
            return config
        default:
            return nil
        }
        return nil
    }
}
