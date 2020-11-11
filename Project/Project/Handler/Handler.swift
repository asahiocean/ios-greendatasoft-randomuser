import Foundation
import Dispatch
import Nuke

final class Handler: SetData, JSON {
    private let storage: StorageManager = StorageManager.shared

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
                do {
                    let _ = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                } catch let error as NSError {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
    
    func setdata(_ data: Data?) {
        if let trueData = data {
            jsonData(trueData, completion: nil)
        } else {
            if let cacheKeys = storage.cache.allKeys() as? [String],
               cacheKeys.isEmpty == false {
                for key in cacheKeys where key.hasPrefix(keyJsonData) {
                    if let data = storage.cache.data(forKey: key) {
                        self.jsonData(data, completion: nil)
                    }
                }
            } else {
                storage.getCoreData(JsondataEntity.self, output: { array in
                    for entity in array {
                        if let data = entity.jsonData {
                            self.jsonData(data, completion: nil)
                        }
                    }
                })
            }
        }
    }
    private init() { }
}
