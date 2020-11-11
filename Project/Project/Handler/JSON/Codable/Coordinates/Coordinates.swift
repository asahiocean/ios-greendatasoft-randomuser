import Foundation

public final class Coordinates: Codable, Equatable, Identifiable {
    public let id: UUID
    public var latitude: String?
    public var longitude: String?
    
    public static func ==(lhs: Coordinates, rhs: Coordinates) -> Bool {
        return lhs.id == rhs.id && lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }

    init(latitude: String?, longitude: String?) {
        self.latitude = latitude
        self.longitude = longitude
        self.id = .init()
    }

    private enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(String.self, forKey: .latitude)
        longitude = try values.decode(String.self, forKey: .longitude)
        id = .init()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
}
