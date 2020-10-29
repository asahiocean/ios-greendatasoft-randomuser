import UIKit

class NavigationController: UINavigationController {

    var mainVC: NotebookVC!
    var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainVC = NotebookVC()
        viewControllers = [mainVC]
        
        navigationBar.barStyle = .black
        navigationBar.isTranslucent = true
    }
}
