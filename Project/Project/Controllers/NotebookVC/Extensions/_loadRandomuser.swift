import Foundation

extension NotebookVC {
    final internal dynamic func _loadRandomUsers() {
        API.shared.loadRandomuser({ [self] db -> Void in
            if persons?.results == nil {
                DispatchQueue.global(qos: .background).sync {
                    persons?.info = db.info
                    for result in db.results {
                        persons?.results.append(result)
                    }
                    DispatchQueue.main.async {
                        _databaseServiceFunction()
                    }
                }
            } else {
                DispatchQueue.global(qos: .background).sync {
                    for result in db.results {
                        persons?.results.append(result)
                    }
                    DispatchQueue.main.async {
                        _databaseServiceFunction()
                    }
                }
            }
        })
    }
}
