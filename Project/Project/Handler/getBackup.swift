import Foundation
import Dispatch

extension Handler {
    func getBackup() {
        guard storage.database == nil else { return }
        
        if let keys = storage.cache.allKeys() as? [String], keys.isEmpty == false {
            for key in keys where key.hasPrefix(jsonDataKey) {
                guard let data = storage.cache.data(forKey: key) else { return }
                self.jsonData(data)
            }
        } else {
            storage.getCoreData(JsondataEntity.self, output: { array -> Void in
                guard let last = array.last, let data = last.jsonData else { return }
                self.jsonData(data)
            })
        }
    }
}
