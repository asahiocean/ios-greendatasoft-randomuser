import UIKit

extension NotebookVC {
    func navigationBarSetup() {

        self.navigationBarCustomTheme(.black, #colorLiteral(red: 0.2253570855, green: 0.2760454416, blue: 0.4227877557, alpha: 1), #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        // 336699
        // 4F4F7E
        
        let wh = (navigationController?.navigationBar.frame.height ??
                    (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? .zero)) * 0.9
        
        let color = navigationController?.navigationBar.tintColor ?? .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage.fontAwesomeIcon(
                name: .gripLines,
                style: .solid,
                textColor: color,
                size: CGSize(width: wh, height: wh)),
            style: .plain,
            target: self,
            action: #selector(alertControllerPresenter))
        
        navigationItem.leftBarButtonItem?.accessibilityIdentifier = "navigationItem.leftBarButtonItem"
    }
}

class LaunchScreenVC: UIViewController {
    
    func gradientSetup(_ uiColors: [UIColor], _ animated: Bool, dur: CFTimeInterval = 3.0) {

        var cgColors: [CGColor] = []
        for color in uiColors { cgColors.append(color.cgColor) }

        let gradient: CAGradientLayer = CAGradientLayer()
            gradient.colors = cgColors
            gradient.startPoint = CGPoint(x: 0, y: 1)
            gradient.endPoint = CGPoint(x: 1, y: 0)
            gradient.frame = self.view.bounds
            gradient.drawsAsynchronously = true

            if animated {
                let animation = CABasicAnimation(keyPath: "colors")
                animation.fromValue = cgColors
                animation.toValue = cgColors.revers()
                animation.duration = dur
                animation.autoreverses = true
                animation.repeatCount = .infinity
                gradient.add(animation, forKey: nil)
            }
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gradientSetup([#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)], true)
    }
}

extension Array {
    func revers() -> Array { self.reversed() }
}
