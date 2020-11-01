import Foundation

extension NotebookVC {
    final internal dynamic func _loadRandomUsers() {
        API.shared.loadRandomuser({ [self] db -> Void in
            if NotebookVC.persons?.results == nil {
                DispatchQueue.main.async {
                    NotebookVC.persons = db
                }
            } else {
                DispatchQueue.global(qos: .background).async {
                    for result in db.results {
                        NotebookVC.persons?.results.append(result)
                    }
                }
            }
            _databaseServiceFunction()
        })
    }
}
