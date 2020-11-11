import Foundation

public final class ID: Codable, Equatable {
    var name: String?
    var value: String?

    init(name: String?, value: String?) {
        self.name = name ?? ""
        self.value = value ?? ""
    }
    
    public static func ==(lhs: ID, rhs: ID) -> Bool {
        return lhs.name == rhs.name && lhs.value == rhs.value
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case value = "value"
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        value = try? values.decode(String.self, forKey: .value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(value, forKey: .value)
    }
}
