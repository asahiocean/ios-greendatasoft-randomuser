import Foundation

public final class Street: Codable, Equatable, Identifiable {
    public let id: UUID
    public let number: Int?
    public let name: String?
    
    public static func ==(lhs: Street, rhs: Street) -> Bool {
        return lhs.number == rhs.number && lhs.name == rhs.name
    }
    
    private enum CodingKeys: String, CodingKey {
        case number = "number"
        case name = "name"
    }

    init(number: Int?, name: String?) {
        self.number = number ?? 0
        self.name = name ?? ""
        self.id = .init()
    }

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        number = try values.decode(Int.self, forKey: .number)
        name = try values.decode(String.self, forKey: .name)
        id = .init()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(number, forKey: .number)
        try container.encode(name, forKey: .name)
    }
}
