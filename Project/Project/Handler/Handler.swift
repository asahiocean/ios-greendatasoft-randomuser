import Foundation
import Dispatch
import Nuke

final class Handler: SetData, JSON {
    private(set) var storage: StorageManager!

    public static let shared = Handler()
    
    internal func jsonData(_ data: Data, completion: ((Any) -> (Void))?) {
        DispatchQueue.main.async {
            if let db = try? jsonDecoder().decode(Database.self, from: data) {
                for i in db.results.indices {
                    let pic = db.results[i].picture
                    API.loadImage(pic.largeUrl, { value in
                        if let image = value {
                            db.results[i].picture.image = image
                        }
                    })
                    if i == db.results.endIndex - 1 {
                        self.storage.setdb(db.results, db.info)
                    }
                }
            } else {
                fatalError()
            }
        }
    }
    
    func setdata(_ data: Data?) {
        if let data = data {
            gettingBackup(completion: { [self] in
                jsonData(data, completion: nil)
            })
        } else {
            gettingBackup(completion: nil)
        }
    }
    
    private init() {
        self.storage = StorageManager.shared
    }
}

