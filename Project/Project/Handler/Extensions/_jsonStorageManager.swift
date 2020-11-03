import Foundation

extension Handler {
    final internal dynamic func jsonStorageManager(_ data: Data) {
        do {
            let json = try jsonDecoder.decode(Database.self, from: data)
            let queue = DispatchQueue(label: "Handler.jsonStorageManager")
            let group = DispatchGroup()
            group.enter()
            queue.async(group: group, execute: {
                StorageManager.shared.setDatabase(json)
                group.leave()
            })
            group.notify(qos: .background, queue: queue, execute: {
                StorageManager.shared.handlerData(data)
            })
        } catch let error as NSError {
            print("Проверьте структуру для декодирования!", error.localizedDescription)
        }
    }
}
