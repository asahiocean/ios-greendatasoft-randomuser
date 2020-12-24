import Foundation
import Dispatch
import Nuke

final class Handler: SetData, JSON {

    public static let shared = Handler()
    public var storage: StorageManager!
    
    func jsonData(_ data: Data, completion: ((Any)->())?) {
        
        guard let db = try? JSONDecoder().decode(Database.self, from: data) else { return }
        
        for i in db.results.indices {
            let url: String = db.results[i].picture.largeUrl
            API.loadImage(url, { image in
                guard let image: UIImage = image else { return }
                db.results[i].picture.image = image
                
                guard i == db.results.endIndex - 1 else { return }
                self.storage.setdb(db.results, db.info)
            })
        }
    }
    
    func setdata(_ data: Data?) {
        guard let data = data else { gettingBackup(completion: nil); return }
        gettingBackup(completion: { self.jsonData(data, completion: nil) })
    }
    
    private init() {
        self.storage = StorageManager.shared
    }
}

