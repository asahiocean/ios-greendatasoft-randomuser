import UIKit

extension NotebookVC: UITableViewDataSource, UITableViewDelegate {
    
    static let nameCell: String = { "NotebookCustomCell" }()
    
    func tableViewConfig() {
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: NotebookCustomCellID, bundle: Bundle.main), forCellReuseIdentifier: NotebookCustomCellID)
        self.view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count > 0 ? persons.count : 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 12
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotebookCustomCellID, for: indexPath) as? NotebookCustomCell
            else { fatalError() }
        cell.label.text = "\(indexPath.row)"
        return cell
    }
}
