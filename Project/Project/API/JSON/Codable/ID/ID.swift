import Foundation

// MARK: - ID
struct ID: Codable {
    var name: String
    var value: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case value = "value"
    }

    public init(name: String, value: String?) {
        self.name = name
        self.value = value ?? ""
    }

    internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        value = try? values.decode(String.self, forKey: .value)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(value, forKey: .value)
    }
}
