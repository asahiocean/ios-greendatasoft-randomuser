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
        case interactionName:
            func contextMenu() -> UIMenu {
                let copy = UIAction(title: "Копировать", image: UIImage(systemName: "doc.text", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)) { action in
                    print(self.fullname.text ?? fatalError())
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
                    print(self.email.text ?? fatalError())
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
