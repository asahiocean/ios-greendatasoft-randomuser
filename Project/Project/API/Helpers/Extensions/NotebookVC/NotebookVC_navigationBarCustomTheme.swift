import UIKit

extension NotebookVC {
    func navigationBarCustomTheme(_ barStyle: UIBarStyle? = .default, _ bg: UIColor? = .systemBackground, _ titleText: UIColor? = .white, _ largeTitle: UIColor? = .white) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = bg
        appearance.titleTextAttributes =
            [.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
        appearance.largeTitleTextAttributes =
            [.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]

        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
