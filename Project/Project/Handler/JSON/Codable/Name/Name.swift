import Foundation

struct Name: Codable {
    let title: String
    var first: String
    var last: String

    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case first = "first"
        case last = "last"
    }

    init(title: String, first: String, last: String) {
        self.title = title
        self.first = first
        self.last = last
    }

    internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        first = try values.decode(String.self, forKey: .first)
        last = try values.decode(String.self, forKey: .last)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(first, forKey: .first)
        try container.encode(last, forKey: .last)
    }

}
