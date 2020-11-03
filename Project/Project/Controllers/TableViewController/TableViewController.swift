import UIKit

final class TableViewController: UITableViewController {

    internal var cellsNumber: Int = 0
    internal var needUpdates: Bool = false
    
    @objc internal dynamic func updater() {
        if needUpdates {
            needUpdates = false
            let group = DispatchGroup()
            let queue = DispatchQueue(label: "TableViewController.updater")
            group.enter()
            queue.async(group: group, qos: .background, execute: {
                API.shared.loadRandomUsers(20)
                group.leave()
            })
            group.notify(queue: .main, execute: { [self] in
                tableView.reloadData()
                needUpdates = true
            })
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        #warning("НИКУДА НЕ УБИРАТЬ! ОСТАВЬ ВНУТРИ viewDidLoad!!!")
        #warning("must register a nib or a class for the identifier or connect a prototype cell in a storyboard")
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCellNib")
        tableView.decelerationRate = .fast // smooth scrolling
        tableView.frame = view.frame
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.clipsToBounds = true
        tableView.setNeedsDisplay()
        tableView.layoutIfNeeded()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        DispatchQueue.global(qos: .background).async { [self] in
            if let results = StorageManager.shared.database?.results.count {
                needUpdates = (results > 0)
                cellsNumber = results
            }
        }

        _navigationBarSetup()
        DispatchQueue.main.async { [self] in

        }
//        _start()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var rotation: CATransform3D
        rotation = CATransform3DMakeRotation((90.0 * .pi) / 180, 0.0, 0.7, 0.4)
        rotation.m34 = 1.0 / -600


        //2. Define the initial state (Before the animation)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 10, height: 10)
        cell.alpha = 0

        cell.layer.transform = rotation
        cell.layer.anchorPoint = CGPoint(x: 0, y: 0.5)


        //3. Define the final state (After the animation) and commit the animation
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.8)
        cell.layer.transform = CATransform3DIdentity
        cell.alpha = 1
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        UIView.commitAnimations()
        
        if indexPath.row > cellsNumber - 8 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                guard tableView.visibleCells.contains(cell) else { return }
                print("QWE", indexPath.row)
//                updater()
            }
        }
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        if let cell = tableView.cellForRow(at: indexPath as IndexPath) as? CustomCell {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//            cell.backgroundColor = .systemRed
//        }
//    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StorageManager.shared.database?.results.count ?? 30
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellNib", for: indexPath)
        cell.backgroundColor = UIColor.systemGreen
        print("cellForRowAt:", indexPath.row)
        return cell

//        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellNib", for: indexPath) as? CustomCell {
//        } else {
//            let cell = UITableViewCell(style: .value1, reuseIdentifier: "CustomCellNib")
//            cell.backgroundColor = UIColor.blue
//            return cell
//        }
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
