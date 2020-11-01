import Foundation

extension NotebookVC {
    final internal dynamic func _loadRandomuser() {
        API.shared.loadRandomuser({ [self] db -> Void in
            if persons?.results == nil {
                persons = db
            } else {
                persons?.results.append(contentsOf: db.results)
            }
        })
    }
}
