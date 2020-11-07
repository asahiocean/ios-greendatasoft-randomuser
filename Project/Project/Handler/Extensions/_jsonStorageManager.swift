import UIKit
import Nuke

extension Handler {
    final func jsonHandler(_ data: Data) {
        let task = ImagePipeline.shared
        do {
            var db = try Self.jsonDecoder.decode(Database.self, from: data)
            for index in db.results.indices {
                task.loadImage(with: URL(string: db.results[index].picture.largeUrl)!, { resp in
                switch resp {
                case let .success(result):
                    db.results[index].picture.image = result.image
                    self.storage.cache.setData(result.image.pngData()!, forKey: db.results[index].picture.id.uuidString)
                case .failure(_): break
                    //db.results[index].picture.thumbnailImage = UIImage(systemName: "person.crop.circle")!
                }
                if index == db.results.endIndex - 1 {
                    self.storage.setdb(results: db.results, info: db.info)
                    updaterGroup.leave()
                }
            })
            }
        } catch let error as NSError {
            print("Проверьте структуру для декодирования!", error.localizedDescription)
        }
    }
}
