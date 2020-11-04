import Foundation

let jsonHandlerQueue = DispatchQueue(label: "com.Handler.jsonHandler")
let jsonHandlerGroup = DispatchGroup()
extension Handler {
    final dynamic func jsonHandler(_ data: Data) {
        do {
            let json = try jsonDecoder.decode(Database.self, from: data)
            jsonHandlerGroup.enter()
            jsonHandlerQueue.async(group: jsonHandlerGroup, qos: .background, execute: {
                StorageManager.shared.setDatabase(json)
                // jsonHandlerGroup.leave()
            })
            jsonHandlerGroup.notify(queue: .main, execute: {
                StorageManager.shared.handlerData(data)
            })
        } catch let error as NSError {
            print("Проверьте структуру для декодирования!", error.localizedDescription)
        }
    }
}
