import UIKit.UITableView

extension NotebookVC: UITableViewDataSource, UITableViewDelegate {
    final internal dynamic func _tableViewSetup() {
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.clipsToBounds = true
        tableView.setNeedsDisplay()
        tableView.layoutIfNeeded()
        
        tableView.separatorStyle = .none
        
        // чтобы выиграть время на загрузку новых пользователей при попытке быстрого скроллинга
        tableView.decelerationRate = .fast //MARK: smooth scrolling
        
        //MARK: Cell
        let nib = UINib(nibName: "NotebookCellNib", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: CustomCellID)
        
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
                
        view.addSubview(tableView)
    }
    
    // MARK: -- heightForRowAt
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 10
    }
    
    
    //MARK: -- numberOfSections & numberOfRowsInSection
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return NotebookVC.persons?.results.count ?? 0
        } else if section == 1 {
            return 1
        }
        return 0
    }
        
    //MARK: -- cellForRowAt
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = CustomCellID
        var cell: CustomCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? CustomCell
        if cell == nil {
            tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CustomCell
        }

        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellID", for: indexPath) as? CustomCell else {
//            return tableView.dequeueReusableCell(withIdentifier: "CustomCellID", for: indexPath)
//        }
        cell.firstname.text = NotebookVC.persons?.results[indexPath.row].name.first
        cell.surname.text = NotebookVC.persons?.results[indexPath.row].name.last
        return cell
    }
    
    //MARK: -- willDisplay cell
    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let count = NotebookVC.persons?.results.count {
            switch indexPath.row {
                case count - 3:
                    tableView.reloadData()
                case count - 6: // preload new results
                    _loadRandomUsers()
                default:
                    break
            }
        }
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) as? CustomCell {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            cell.backgroundColor = .systemRed
        }
    }
}
