import Foundation

extension NotebookVC {
    internal func _loadRandomuser() {
        API.shared.loadRandomuser({ [self] db -> Void in
            if persons == nil {
                persons = db
            } else {
                let results = db.results
                let appendQueue = DispatchQueue(label: "loadRandomuser.background.concurrent.queue", qos: .background, attributes: .concurrent)
                appendQueue.sync(flags: .barrier) {
                    for person in results {
                        persons?.results.append(person)
                    }
                }
            }
        })
    }
}
