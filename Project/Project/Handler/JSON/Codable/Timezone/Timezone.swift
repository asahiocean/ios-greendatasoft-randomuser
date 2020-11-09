import Foundation

public final class Timezone: Codable, Equatable, Identifiable {
    public let id: UUID
    public let offset: String?
    public let descriptionTimezone: String?
    
    public static func ==(lhs: Timezone, rhs: Timezone) -> Bool {
        return lhs.id == rhs.id && lhs.offset == rhs.offset && lhs.descriptionTimezone == rhs.descriptionTimezone
    }

    enum CodingKeys: String, CodingKey {
        case offset
        case descriptionTimezone = "description"
    }
    
    init(offset: String?, descriptionTimezone: String?) {
        self.offset = offset ?? ""
        self.descriptionTimezone = descriptionTimezone ?? ""
        self.id = .init()
    }

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        offset = try values.decode(String.self, forKey: .offset)
        descriptionTimezone = try values.decode(String.self, forKey: .descriptionTimezone)
        id = .init()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(offset, forKey: .offset)
        try container.encode(descriptionTimezone, forKey: .descriptionTimezone)
    }

}
