import UIKit

class NavigationController: UINavigationController {

    var mainVC: NotebookVC!

    override func viewDidLoad() {
        super.viewDidLoad()
        mainVC = NotebookVC()
        viewControllers = [mainVC]
    }
}
