import Foundation

public final class Location: Codable {
    public let id: UUID
    public let street: Street
    public let city: String?
    public let state: String?
    public let country: String?
    public let postcode: Postcode
    public let coordinates: Coordinates
    public let timezone: Timezone

    init(street: Street, city: String?, state: String?, country: String?, postcode: Postcode, coordinates: Coordinates, timezone: Timezone) {
        self.street = street
        self.city = city ?? ""
        self.state = state ?? ""
        self.country = country ?? ""
        self.postcode = postcode
        self.coordinates = coordinates
        self.timezone = timezone
        self.id = .init()
    }
    
    public static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id && lhs.street == rhs.street && lhs.city == rhs.city && lhs.state == rhs.state && lhs.country == rhs.country && lhs.postcode == rhs.postcode && lhs.coordinates == rhs.coordinates && lhs.timezone == rhs.timezone
    }
    
    private enum CodingKeys: String, CodingKey {
        case street = "street"
        case city = "city"
        case state = "state"
        case country = "country"
        case postcode = "postcode"
        case coordinates = "coordinates"
        case timezone = "timezone"
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        street = try values.decode(Street.self, forKey: .street)
        city = try values.decode(String.self, forKey: .city)
        state = try values.decode(String.self, forKey: .state)
        country = try values.decode(String.self, forKey: .country)
        postcode = try values.decode(Postcode.self, forKey: .postcode)
        coordinates = try values.decode(Coordinates.self, forKey: .coordinates)
        timezone = try values.decode(Timezone.self, forKey: .timezone)
        id = UUID()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(street, forKey: .street)
        try container.encode(city, forKey: .city)
        try container.encode(state, forKey: .state)
        try container.encode(country, forKey: .country)
        try container.encode(postcode, forKey: .postcode)
        try container.encode(coordinates, forKey: .coordinates)
        try container.encode(timezone, forKey: .timezone)
    }
}
