import Foundation
import Nuke.Swift

extension API {
    func loadImage(_ urlString: String, _ completion: @escaping (UIImage?)->()) {
        
        let pipeline = ImagePipeline.shared
        let request = ImageRequest(url: URL(string: urlString)!, priority: .veryHigh)
        
        if let cached = pipeline.cachedImage(for: request) {
            completion(cached.image)
        } else {
            pipeline.loadImage(with: request, completion: { response in
                switch response {
                case let .success(result):
                    completion(result.image)
                case let .failure(error):
                    print(error.localizedDescription)
                    completion(UIImage(named: "avatar"))
                }
            })
        }
    }
}
