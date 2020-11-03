import Foundation

struct Street: Codable {
    var number: Int
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case number = "number"
        case name = "name"
    }

    init(number: Int, name: String) {
        self.number = number
        self.name = name
    }

    internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        number = try values.decode(Int.self, forKey: .number)
        name = try values.decode(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(number, forKey: .number)
        try container.encode(name, forKey: .name)
    }

}
