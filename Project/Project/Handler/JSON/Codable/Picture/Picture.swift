import UIKit

struct Picture: Codable, Equatable, Identifiable {
    var id: UUID
    var large: String
    var medium: String
    var thumbnail: String
    
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
    }

    internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        large = try values.decode(String.self, forKey: .large)
        medium = try values.decode(String.self, forKey: .medium)
        thumbnail = try values.decode(String.self, forKey: .thumbnail)
        id = UUID()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(large, forKey: .large)
        try container.encode(medium, forKey: .medium)
        try container.encode(thumbnail, forKey: .thumbnail)
    }

}
