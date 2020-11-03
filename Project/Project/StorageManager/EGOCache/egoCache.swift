import Foundation

extension StorageManager {
    public dynamic func egoCache(_ data: Data) {
        let timestamp = Int(Date().timeIntervalSince1970)
        let key = "jsondata\(timestamp)"
        self.cache.setData(data, forKey: key, withTimeoutInterval: 2592000) // 2592000 sec == 1 month
    }
}
