import UIKit.UIGeometry

extension TableViewController {
    final internal dynamic func _navigationBarSetup() {
        self.title = "Notebook"
        
        _navigationBarColorConfig(.black, bg: #colorLiteral(red: 0.2253570855, green: 0.2760454416, blue: 0.4227877557, alpha: 1), font: #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), tint: #colorLiteral(red: 0.1126997098, green: 0.1422483027, blue: 0.2217662632, alpha: 1))
        
        let wh = (navigationController?.navigationBar.frame.height ??
                    (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? .zero)) * 0.9
        let buttonSize: CGSize = CGSize(width: wh, height: wh)
        let color = navigationController?.navigationBar.tintColor ?? .white
        
        _navigationBarLeftButton(size: buttonSize, textColor: color) //MARK: <- Left Button Action
        
        navigationItem.leftBarButtonItem?.accessibilityIdentifier = "navigationItem.leftBarButtonItem"
    }
}
