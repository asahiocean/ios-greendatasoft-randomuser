import UIKit
import Nuke

func loaderImage(_ urlStr: String) -> UIImage {
    if let url = URL(string: urlStr), let data = try? Data(contentsOf: url) {
        return UIImage(data: data)!
    }
    return UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.SymbolConfiguration(weight: .light))!
}

struct Picture: Codable, Equatable, Identifiable {
    var id: UUID
    var large: String
    var medium: String
    var thumbnail: String
    
    var largeImage: UIImage?
    var mediumImage: UIImage?
    var thumbnailImage: UIImage?
    
    static func ==(lhs: Picture, rhs: Picture) -> Bool {
        return lhs.large == rhs.large && lhs.medium == rhs.medium && lhs.thumbnail == rhs.thumbnail
    }
        
    private enum CodingKeys: String, CodingKey {
        case large = "large"
        case medium = "medium"
        case thumbnail = "thumbnail"
    }
    
    init(large: String, medium: String, thumbnail: String) {
        self.large = large
        self.medium = medium
        self.thumbnail = thumbnail
        self.id = UUID()
        self.largeImage = UIImage()
        self.mediumImage = UIImage()
        self.thumbnailImage = UIImage()
    }
    
    internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        large = try values.decode(String.self, forKey: .large)
        medium = try values.decode(String.self, forKey: .medium)
        thumbnail = try values.decode(String.self, forKey: .thumbnail)
        id = UUID()
        largeImage = UIImage()
        mediumImage = UIImage()
        thumbnailImage = UIImage()
        //ImageRequest(url: URL(string: try values.decode(String.self, forKey: .thumbnail))!)
//         thumbnailImage = loaderImage(try values.decode(String.self, forKey: .thumbnail))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(large, forKey: .large)
        try container.encode(medium, forKey: .medium)
        try container.encode(thumbnail, forKey: .thumbnail)
    }

}
