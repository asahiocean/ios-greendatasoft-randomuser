import Foundation

struct Timezone: Codable, CustomStringConvertible {
    var offset: String
    var description: String

    enum CodingKeys: String, CodingKey {
        case offset
        case description = "description"
    }
    
    init(offset: String, description: String) {
        self.offset = offset
        self.description = description
    }

    internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        offset = try values.decode(String.self, forKey: .offset)
        description = try values.decode(String.self, forKey: .description)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(offset, forKey: .offset)
        try container.encode(description, forKey: .description)
    }

}
