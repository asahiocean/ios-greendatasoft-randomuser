import Foundation
import SimpleImageViewer
import UIKit

extension UserinfoVC: UIContextMenuInteractionDelegate {
    
    private static let icon_copy: UIImage! = {
        return UIImage(systemName: "doc.text", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
    }()

    private static let icon_map: UIImage! = {
        return UIImage(systemName: "map", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
    }()
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        switch interaction {
        case interactionMap:
            func contextMenu() -> UIMenu {
                let copy = UIAction(title: "Копировать адрес", image: Self.icon_copy) { [weak self] action in

                    pasteboard.string = self?.address
                    
                    if let location = try? self?.result?.location.jsonString() {
                        API.shared.report(key: "Copied address", value: location)
                    }
                }
                                
                let map = UIAction(title: "Перейти в Карты", image: Self.icon_map) { action in
                    if let coord = self.location?.coordinates, let lat = coord.latitude, let lon = coord.longitude {
                        if let url = URL(string: "https://maps.apple.com/?ll=\(lat),\(lon)") {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                }
                return UIMenu(title: "", children: [map, copy])
            }
            let config = UIContextMenuConfiguration(identifier: nil, previewProvider: { () -> UIViewController? in
                return nil
            }) { _ -> UIMenu? in
                return contextMenu()
            }
            return config
        case interactionPhoto:
            let config = ImageViewerConfiguration { config in config.imageView = photo }
            let controller = ImageViewerController(configuration: config)
            present(controller, animated: true)
            
            if let url = result?.picture.largeUrl {
                API.shared.report(key: "User opened photo", value: url)
            }
        case interactionName:
            func contextMenu() -> UIMenu {
                let copy = UIAction(title: "Копировать", image: Self.icon_copy) { action in
                    if let username = self.fullname.text {
                        let pasteboard = UIPasteboard.general
                        pasteboard.string = username
                        API.shared.report(key: "Username copied", value: username)
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
        case interaction_Email:
            func contextMenu() -> UIMenu {
                let copy = UIAction(title: "Копировать", image: Self.icon_copy) { action in
                    if let email = self.email.text {
                        
                        pasteboard.string = email
                        API.shared.report(key: "Email copied", value: email)
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
