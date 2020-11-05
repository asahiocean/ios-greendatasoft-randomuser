import UIKit
import Nuke

let updaterQueue = DispatchQueue(label: "com.updater.queue", qos: .background, attributes: .concurrent)
let updaterGroup = DispatchGroup()

final class TableViewController: UITableViewController {
    
    internal var needUpdates: Bool = true
    internal let storage = StorageManager.shared
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomCell.nib, forCellReuseIdentifier: CustomCell.identifier); #warning("tableView.register НИКУДА НЕ УБИРАТЬ!")
        tableView.decelerationRate = .fast // smooth scrolling
        updater()
        _navigationBarSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewSetup()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let results = storage.database?.results, indexPath.row > (results.count - 8), needUpdates == false else { return }
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.1, execute: { [self] in
            guard tableView.visibleCells.contains(cell) else { return }
            needUpdates = true
            updater()
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // tableView.deselectRow(at: indexPath, animated: true)
//        if let cell = tableView.cellForRow(at: indexPath as IndexPath) as? CustomCell {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//            cell.backgroundColor = .systemRed
//        }
    }
    
// MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }
    //MARK: -- numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.database?.results.count ?? 0
    }
    //MARK: -- Height
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return tableView.bounds.height / 10
//    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 10
    }
    //MARK: -- cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: CustomCell = (tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath as IndexPath) as? CustomCell) { // #warning("OK!")
            cell.firstname?.text =
                storage.database?.results[indexPath.row].name.first
            cell.surname?.text =
                storage.database?.results[indexPath.row].name.last
            cell.imageViewPhoto?.image = storage.database?.results[indexPath.row].picture.thumbnailImage
            return cell
        } else {
            let defaultCell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: CustomCell.identifier)
            defaultCell.backgroundColor = UIColor.systemRed
            return defaultCell
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension UITableView {
    func reloadDataSavingSelections() {
        let selectedRows = indexPathsForSelectedRows

        reloadData()

        if let selectedRow = selectedRows {
            for indexPath in selectedRow {
                selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
        }
    }
}
