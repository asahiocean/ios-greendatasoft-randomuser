import Foundation
import UIKit.UITableView
import UIKit.UITableViewCell

extension TableViewController {
    //MARK: -- cellForRowAt & dequeueReusableCell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = (tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell) {
            if let res = storage.database?.results[indexPath.row] {
                cell.set(result: res)
            }
            return cell
        } else {
            let defaultCell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: CustomCell.identifier)
            defaultCell.backgroundColor = UIColor.systemRed
            return defaultCell
        }
    }
}
