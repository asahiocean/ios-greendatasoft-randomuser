import UIKit

class NavigationController: UINavigationController {
    
    private let vc = TableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [vc]
    }
}
