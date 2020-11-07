import UIKit
import Nuke

public struct Picture: Codable, Equatable, Identifiable {
    public let id: UUID
    public let largeUrl: String
    public let mediumUrl: String
    public let thumbnailUrl: String
    
    public var image: UIImage
    
    public static func ==(lhs: Picture, rhs: Picture) -> Bool {
        return lhs.largeUrl == rhs.largeUrl && lhs.mediumUrl == rhs.mediumUrl && lhs.thumbnailUrl == rhs.thumbnailUrl
    }
        
    private enum CodingKeys: String, CodingKey {
        case large = "large"
        case medium = "medium"
        case thumbnail = "thumbnail"
    }
            
    init(large: String, medium: String, thumbnail: String) {
        self.largeUrl = large
        self.mediumUrl = medium
        self.thumbnailUrl = thumbnail
        self.id = UUID()
        
        self.image = UIImage(systemName: "person.crop.circle")!
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        largeUrl = try values.decode(String.self, forKey: .large)
        mediumUrl = try values.decode(String.self, forKey: .medium)
        thumbnailUrl = try values.decode(String.self, forKey: .thumbnail)
        id = UUID()
        image = UIImage()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(largeUrl, forKey: .large)
        try container.encode(mediumUrl, forKey: .medium)
        try container.encode(thumbnailUrl, forKey: .thumbnail)
    }
}
