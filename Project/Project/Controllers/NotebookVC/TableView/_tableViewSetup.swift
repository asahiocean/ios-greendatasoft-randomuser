import UIKit.UITableView

extension NotebookVC: UITableViewDataSource, UITableViewDelegate {
    final internal dynamic func _tableViewSetup() {
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        // чтобы выиграть время на загрузку новых пользователей при попытке быстрого скроллинга
        tableView.decelerationRate = .fast //MARK: smooth scrolling
        
        //MARK: Cell
        let cell = UINib(nibName: NotebookCustomCellID, bundle: .main)
        let identifier = NotebookCustomCellID
        tableView.register(cell, forCellReuseIdentifier: identifier)
        
        view.addSubview(tableView)
    }
    
    // MARK: -- heightForRowAt
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 10
    }
    
    //MARK: -- numberOfRowsInSection
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons?.results.count ?? .zero
    }
    //MARK: -- cellForRowAt
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let customCell = tableView.dequeueReusableCell(withIdentifier: NotebookCustomCellID, for: indexPath as IndexPath) as? NotebookCustomCell {
            customCell.firstname.text = persons?.results[indexPath.row].name.first
            customCell.surname.text = persons?.results[indexPath.row].name.last
            return customCell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: NotebookCustomCellID)
        }
    }
        
    //MARK: -- willDisplay cell
    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let count = persons?.results.count {
            switch indexPath.row {
                case count - 10: // preload new results
                    _loadRandomuser()
                default: break
            }
        }
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) as? NotebookCustomCell {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            cell.backgroundColor = .systemRed
        }
    }
}
