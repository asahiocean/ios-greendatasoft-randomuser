import UIKit.UITableViewController

final class TableViewController: UITableViewController {
    
    internal let storage = StorageManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomCell.nib, forCellReuseIdentifier: CustomCell.identifier); #warning("tableView.register НИКУДА НЕ УБИРАТЬ!")
        navigationBarSetup()
        tableViewSetup()
        updater()
    }
}
