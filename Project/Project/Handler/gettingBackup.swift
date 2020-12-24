import Foundation

extension Handler {
    internal func gettingBackup(completion: (() -> (Void))?) {
        let quene = DispatchQueue(label: "com.handler.gettingBackup", qos: .background)
        let group = DispatchGroup()
        
        group.enter()
        quene.async(group: group, execute: { [self] in
            
            if storage.database == nil {
                if let keys = storage.cache.allKeys() as? [String], keys.isEmpty == false {
                    
                for key in keys where key.hasPrefix(keyJsonData) {
                    if let data = storage.cache.data(forKey: key) {
                        jsonData(data, completion: { _ in group.leave() })
                    }
                }
            } else {
                storage.getCoreData(JsondataEntity.self, output: { [self] array -> Void in
                    if let last = array.last, let data = last.jsonData {
                        jsonData(data, completion: { _ in group.leave() })
                    } else {
                        group.leave()
                    }
                })
            }
            } else {
                group.leave()
            }
        })
        group.notify(queue: quene, execute: {
            if let task = completion { task() }
        })
    }
}
