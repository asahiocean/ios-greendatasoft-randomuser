import UIKit

extension NotebookVC {
    internal func _navigationBarThemeConfig(_ barStyle: UIBarStyle? = .default,
                                  bg: UIColor?,
                                  fontColor: UIColor?,
                                  tintColor: UIColor?
    ) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = bg ?? .systemBackground
        appearance.titleTextAttributes =
            [.foregroundColor: fontColor ?? .white]
        
        navigationController?.navigationBar.barStyle = barStyle ?? .default
        navigationController?.navigationBar.tintColor = tintColor ?? .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
