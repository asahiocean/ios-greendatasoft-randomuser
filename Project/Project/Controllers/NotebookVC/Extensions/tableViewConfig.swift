import UIKit

extension NotebookVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableViewSetup() {
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: NotebookCustomCellID, bundle: Bundle.main), forCellReuseIdentifier: NotebookCustomCellID)
        view.addSubview(tableView)
        helper()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return persons?.results.count ?? 0
        } else if section == 1 && fetchingMore {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 12
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotebookCustomCellID, for: indexPath) as? NotebookCustomCell else { fatalError() }
        cell.label.text = persons?.results[indexPath.row].name.first
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let count = persons?.results.count else { return }
        if indexPath.row == count - 3 {
            loadRandomuser()
            tableView.decelerationRate = UIScrollView.DecelerationRate(rawValue: 0.95)
        }
    }
}

extension NotebookVC {
    fileprivate func helper() {
        
    }
}
