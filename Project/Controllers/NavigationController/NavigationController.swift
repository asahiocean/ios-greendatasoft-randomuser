import UIKit

class NavigationController: UINavigationController {
    
    fileprivate var tableView: TableViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = TableViewController()
        self.viewControllers = [tableView]
    }
}
