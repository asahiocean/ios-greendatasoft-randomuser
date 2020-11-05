import UIKit
import Nuke

extension Handler {
    final func jsonHandler(_ data: Data) {
        do {
            var db = try Self.jsonDecoder.decode(Database.self, from: data)
            for index in db.results.indices {
                ImagePipeline.shared.loadImage(with: URL(string: db.results[index].picture.thumbnail)!, { response in
                    switch response {
                    case .failure:
                        db.results[index].picture.thumbnailImage = UIImage(systemName: "person.crop.circle")
                    case let .success(imageResponse):
                        db.results[index].picture.thumbnailImage = imageResponse.image
                    }
                    switch index == db.results.endIndex - 1 {
                    case true:
                        print("case true")
                        self.storage.setdb(results: db.results, info: db.info)
                        updaterGroup.leave()
                    default:
                        //print("break", index)
                        break
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
