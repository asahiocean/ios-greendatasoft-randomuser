import Foundation
import Nuke.Swift

extension API {
    static func loadImageData(_ urlSrt: String, _ completion: @escaping (Data?)->()) {
        guard let url = URL(string: urlSrt) else { fatalError() }
        let request = ImageRequest(url: url, priority: .veryLow)
        if let cached = ImagePipeline.shared.cachedImage(for: request) {
            completion(cached.image.pngData())
        } else {
            ImagePipeline.shared.loadImage(with: request, { response in
                switch response {
                case let .success(result):
                    completion(result.image.pngData())
                case let .failure(error):
                    completion(nil)
                }
            })
        }
    }
}
