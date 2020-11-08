import Foundation
import Dispatch
import Nuke

final class Handler: SetData, JSON {
    internal var jsonDecoder: JSONDecoder!
    private let storage: StorageManager = StorageManager.shared

    public static let shared = Handler()
    
    func setdata(_ data: Data?) {
        if let data = data {
            DispatchQueue.main.async { [self] in
                if let db = try? jsonDecoder.decode(Database.self, from: data) {
                    self.storage.setdb(results: db.results, info: db.info)
                } else {
                    fatalError("Fail decode: Database")
                }
            }
        } else {
            if let allKeys = storage.cache.allKeys() as? [String] {
                for item in allKeys.sorted() where item.hasPrefix(keyJsonData) {
                    if let data = storage.cache.data(forKey: item) {
                        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1, execute: { [self] in
                            if let db = try? jsonDecoder.decode(Database.self, from: data) {
                                self.storage.setdb(results: db.results, info: db.info)
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
