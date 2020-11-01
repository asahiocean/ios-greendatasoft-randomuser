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
        tableView.register(UINib(nibName: NotebookCellID, bundle: .main), forCellReuseIdentifier: NotebookCellID)
        
        view.addSubview(tableView)
    }
    
    // MARK: -- heightForRowAt
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 10
    }
    
    
    //MARK: -- numberOfSections & numberOfRowsInSection
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons?.results.count ?? .zero
    }
    //MARK: -- cellForRowAt
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotebookCellID, for: indexPath) as? NotebookCell else { fatalError() }
        cell.firstname.text = persons?.results[indexPath.row].name.first
        cell.surname.text = persons?.results[indexPath.row].name.last
        return cell
    }
        
    //MARK: -- willDisplay cell
    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let count = persons?.results.count {
            switch indexPath.row {
                case count - 6: // preload new results
                    _loadRandomUsers()
                default: break
            }
        }
    }
        
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) as? NotebookCell {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            cell.backgroundColor = .systemRed
        }
    }
}
