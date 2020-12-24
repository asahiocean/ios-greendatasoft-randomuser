import UIKit

final class TableViewController: UITableViewController {
    
    internal let storage = StorageManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomCell.nib, forCellReuseIdentifier: CustomCell.id);
        navigationBarSetup()
        tableViewSetup()
        updater()
    }
}
