import UIKit

struct Picture: Codable {
    var large: String
    var medium: String
    var thumbnail: String
    
//    var large_image: UIImage
//    var medium_image: UIImage
//    var thumbnail_image: UIImage
    
    private enum CodingKeys: String, CodingKey {
        case large = "large"
        case medium = "medium"
        case thumbnail = "thumbnail"
    }

    init(large: String, medium: String, thumbnail: String) {
        self.large = large
        self.medium = medium
        self.thumbnail = thumbnail
        
//        self.large_image = loadImage(large)
//        self.medium_image = loadImage(medium)
//        self.thumbnail_image = loadImage(thumbnail)
    }

    internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        large = try values.decode(String.self, forKey: .large)
        medium = try values.decode(String.self, forKey: .medium)
        thumbnail = try values.decode(String.self, forKey: .thumbnail)
//        large_image = self.loadImage(try values.decode(String.self, forKey: .large))
//        medium_image = self.loadImage(try values.decode(String.self, forKey: .medium))
//        thumbnail_image = self.loadImage(try values.decode(String.self, forKey: .thumbnail))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(large, forKey: .large)
        try container.encode(medium, forKey: .medium)
        try container.encode(thumbnail, forKey: .thumbnail)
    }

}
