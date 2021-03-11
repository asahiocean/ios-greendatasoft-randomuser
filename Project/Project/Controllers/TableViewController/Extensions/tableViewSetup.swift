import UIKit

extension TableViewController {
    internal func tableViewSetup() {
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = rowHeight
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.decelerationRate = .fast
        tableView.contentInsetAdjustmentBehavior = .never
        
        let indicatorView = UIActivityIndicatorView(style: .large)
        tableView.backgroundView = indicatorView
        indicatorView.startAnimating()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.database?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let results = storage.database?.results.count, indexPath.row == (results - 5) else { return }
        self.updater(15)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.id, for: indexPath) as! CustomCell
        if let result = storage.database?.results[indexPath.row] { cell.setResult(result) }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let result = storage.database?.results[indexPath.row], let nav = navigationController {
            if let userinfo = UserinfoVC.nib.instantiate(withOwner: nil, options: nil)[0] as? UserinfoVC {
                userinfo.setResult(result)
                nav.pushViewController(userinfo, animated: true)
            }
        }
    }
}
