import Foundation
import Nuke.Swift

extension API {
    static func loadImage(_ urlSrt: String, _ completion: @escaping (UIImage?)->()) {
        guard let url = URL(string: urlSrt) else { fatalError() }
        let request = ImageRequest(url: url, priority: .high)
        if let cached = ImagePipeline.shared.cachedImage(for: request) {
            completion(cached.image); // print("< Cached image:", cached.image.pngData() ?? 0, "-> URL:", url.absoluteString)
        } else {
            ImagePipeline.shared.loadImage(with: request, { response in
                switch response {
                case let .success(result):
                    completion(result.image); // print("Load image:", result.image.pngData() ?? 0, "-> URL:", url.absoluteString)
                case let .failure(error):
                    print(error.localizedDescription)
                    completion(nil)
                }
            })
        }
    }
}
