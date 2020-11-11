import Foundation
import SimpleImageViewer
import UIKit

extension UserinfoVC: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        switch interaction {
        case interactionMap:
            func contextMenu() -> UIMenu {
                let copy = UIAction(title: "Копировать адрес", image: UIImage(systemName: "doc.text", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)) { action in
                    let pasteboard = UIPasteboard.general
                    pasteboard.string = self.address
                    DispatchQueue.global(qos: .utility).async {
                        if let address = try? self.result?.location.jsonString(), let url = URL(string: Url.post.rawValue) {
                            API.post(.contentType, URLRequest(url: url), ["Copied address": address])
                        }
                    }
                }
                
                let map = UIAction(title: "Перейти в Карты", image: UIImage(systemName: "map", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)) { action in
                    if let coord = self.location?.coordinates {
                        if let url = URL(string: "https://maps.apple.com/?ll=\(coord.latitude!),\(coord.longitude!)") {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                }
                return UIMenu(title: "", children: [map, copy])
            }
            let config = UIContextMenuConfiguration(
                identifier: nil,
                previewProvider: { () -> UIViewController? in
                return nil
            }) { _ -> UIMenu? in
                return contextMenu()
            }
            return config
        case interactionPhoto:
            let cfg = ImageViewerConfiguration { config in
                config.imageView = photo
            }
            let ivc = ImageViewerController(configuration: cfg)
            present(ivc, animated: true)
            DispatchQueue.global(qos: .utility).async {
                if let photoUrl = self.result?.picture.largeUrl, let url = URL(string: Url.post.rawValue) {
                    API.post(.contentType, URLRequest(url: url), ["User opened photo": photoUrl])
                }
            }
        case interactionName:
            func contextMenu() -> UIMenu {
                let copy = UIAction(title: "Копировать", image: UIImage(systemName: "doc.text", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)) { action in
                    if let username = self.fullname.text {
                        let pasteboard = UIPasteboard.general
                        pasteboard.string = username
                        
                        DispatchQueue.global(qos: .utility).async {
                            if let url = URL(string: Url.post.rawValue) {
                                API.post(.contentType, URLRequest(url: url), ["Username copied": username])
                            }
                        }
                    }
                }
                return UIMenu(title: "", children: [copy])
            }
            
            let config = UIContextMenuConfiguration(
                identifier: nil,
                previewProvider: { () -> UIViewController? in
                return nil
            }) { _ -> UIMenu? in
                return contextMenu()
            }
            return config
        case interactionEmail:
            func contextMenu() -> UIMenu {
                let copy = UIAction(title: "Копировать", image: UIImage(systemName: "doc.text", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)) { action in
                    if let email = self.email.text {
                        let pasteboard = UIPasteboard.general
                        pasteboard.string = email
                        
                        DispatchQueue.global(qos: .utility).async {
                            if let url = URL(string: Url.post.rawValue) {
                                API.post(.contentType, URLRequest(url: url), ["Email copied": email])
                            }
                        }
                    }
                }
                return UIMenu(title: "", children: [copy])
            }
            
            let config = UIContextMenuConfiguration(
                identifier: nil,
                previewProvider: { () -> UIViewController? in
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
