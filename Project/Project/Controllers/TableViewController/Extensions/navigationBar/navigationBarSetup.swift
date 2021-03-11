import UIKit.UIGeometry

extension TableViewController {
    final func navigationBarSetup() {
        title = "Notebook"
        
        _navigationBarColorConfig(.black, bg: #colorLiteral(red: 0.2253570855, green: 0.2760454416, blue: 0.4227877557, alpha: 1), font: #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), tint: #colorLiteral(red: 0.1126997098, green: 0.1422483027, blue: 0.2217662632, alpha: 1))
        
        let h1: CGFloat = (navigationController?.navigationBar.frame.height ?? .zero) * 0.9
        let h2: CGFloat = (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? .zero) * 0.9
        
        let buttonSize: CGSize = CGSize(width: h1 > 0 ? h1 : h2, height: h1 > 0 ? h1 : h2)
        
        let color = navigationController?.navigationBar.tintColor ?? .white
        
        navigationBar_left_button(size: buttonSize, textColor: color) //MARK: <- Left Button Action
        navigationItem.leftBarButtonItem?.accessibilityIdentifier = "navigationItem.leftBarButtonItem"
        
        _navigationBarRightActivityIndicator()
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "navigationItem.rightBarButtonItem"
    }
}
