import UIKit
import SimpleImageViewer

extension NotebookVC: UITableViewDataSource, UITableViewDelegate {
    internal func _tableViewSetup() {
        tableView = UITableView(frame: view.frame, style: .plain)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotebookCustomCellID, for: indexPath) as? NotebookCustomCell else { fatalError() }
        cell.firstname.text = persons?.results[indexPath.row].name.first
        cell.surname.text = persons?.results[indexPath.row].name.last
        return cell
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
        print("")
    }
}
