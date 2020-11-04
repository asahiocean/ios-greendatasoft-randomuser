import Foundation

struct Name: Codable, Equatable, Identifiable {
    var id: UUID
    let title: String
    var first: String
    var last: String
    
    static func ==(lhs: Name, rhs: Name) -> Bool {
        return lhs.title == rhs.title && lhs.first == rhs.first && lhs.last == rhs.last
    }

    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case first = "first"
        case last = "last"
    }

    init(title: String, first: String, last: String) {
        self.title = title
        self.first = first
        self.last = last
        self.id = UUID()
    }

    internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        first = try values.decode(String.self, forKey: .first)
        last = try values.decode(String.self, forKey: .last)
        id = UUID()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(first, forKey: .first)
        try container.encode(last, forKey: .last)
    }

}
