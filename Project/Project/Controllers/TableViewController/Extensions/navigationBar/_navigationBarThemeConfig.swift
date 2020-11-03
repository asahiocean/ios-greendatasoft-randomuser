import UIKit

extension TableViewController {
    internal func _navigationBarColorConfig(_ style: UIBarStyle? = .default, bg: UIColor?, font: UIColor?, tint: UIColor?){
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = bg ?? .systemBackground
        appearance.titleTextAttributes =
            [.foregroundColor: font ?? .white]
        
        navigationController?.navigationBar.barStyle = style ?? .default
        navigationController?.navigationBar.tintColor = tint ?? .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
