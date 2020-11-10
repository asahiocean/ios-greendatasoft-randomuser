import Foundation
import Dispatch
import Nuke

final class Handler: SetData, JSON {
    private let storage: StorageManager = StorageManager.shared

    public static let shared = Handler()

    internal func jsonData(_ data: Data, completion: ((Any) -> (Void))?) {
        DispatchQueue.main.async {
            guard let db = try? newJSONDecoder().decode(Database.self, from: data) else { fatalError() }
            for i in db.results.indices {
                let pic = db.results[i].picture
                API.loadImage(pic.largeUrl, { value in
                    if let image = value {
                        db.results[i].picture.image = image
                    } else {
                        db.results[i].picture.image = UIImage(named: "avatar")!
                    }
                })
                if i == db.results.endIndex - 1 {
                    self.storage.setdb(db.results, db.info)
                }
            }
        }
    }
    
    func setdata(_ data: Data?) {
        if let data = data {
            jsonData(data, completion: nil)
        } else {
            if let allKeys = storage.cache.allKeys() as? [String] {
                for item in allKeys.sorted() where item.hasPrefix(keyJsonData) {
                    if let data = storage.cache.data(forKey: item) {
                        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1, execute: {
                            if let db = try? newJSONDecoder().decode(Database.self, from: data) {
                                fatalError()
                                // storage.setdb(db.results,db.info)
                            }
                        })
                    }
                }
            } else {
            storage.getCoreData(JsondataEntity.self, output: { data in
                print(data.enumerated())
            })
            }
        }
    }
    private init() { }
}
