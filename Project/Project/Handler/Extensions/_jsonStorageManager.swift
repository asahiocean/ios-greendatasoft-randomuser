import UIKit
import Nuke

extension Handler {
    final func jsonHandler(_ data: Data) {
        let task = ImagePipeline.shared
        do {
            var db = try Self.jsonDecoder.decode(Database.self, from: data)
            for index in db.results.indices {
            task.loadImage(with: URL(string: db.results[index].picture.mediumUrl)!, { resp in
                switch resp {
                case let .success(result):
                    db.results[index].picture.image = result.image
                if let data = result.image.pngData() {
                self.storage.cache.setData(data, forKey: "\(db.results[index].picture.id)")
                }
                case .failure(_):
                    db.results[index].picture.image =
                        UIImage(systemName: "person.crop.circle")!
                }
                if index == db.results.endIndex - 1 {
                    self.storage.setdb(results: db.results, info: db.info)
                    updaterGroup.leave()
                }
            })
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                StorageManager.shared.handlerData(data)
            })
        } catch let error as NSError {
            print("Проверьте структуру для декодирования!", error.localizedDescription)
        }
    }
}

// UIImage(data: try Data(contentsOf:  URL()))
