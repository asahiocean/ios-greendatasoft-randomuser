import UIKit

extension TableViewController {
    internal func _navigationBarColorConfig(_ style: UIBarStyle?, bg: UIColor?, font: UIColor?, tint: UIColor?) {
        let appearance = UINavigationBarAppearance()
        
        if let fontColor = font, let bgcolor = bg {
            appearance.backgroundColor = bgcolor
            appearance.titleTextAttributes = [.foregroundColor: fontColor]
        } else {
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.backgroundColor = .systemBackground
        }
        
        navigationController?.navigationBar.barStyle = style ?? .default
        navigationController?.navigationBar.tintColor = tint ?? .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
