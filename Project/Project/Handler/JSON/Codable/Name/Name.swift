import Foundation

public final class Name: Codable {
    public let id: UUID
    public let title: String?
    public let first: String?
    public let last: String?

    init(title: String?, first: String?, last: String?) {
        self.title = title ?? ""
        self.first = first ?? ""
        self.last = last ?? ""
        self.id = .init()
    }
    
    public static func ==(lhs: Name, rhs: Name) -> Bool {
        return lhs.title == rhs.title && lhs.first == rhs.first && lhs.last == rhs.last
    }
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case first = "first"
        case last = "last"
    }

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        first = try values.decode(String.self, forKey: .first)
        last = try values.decode(String.self, forKey: .last)
        id = UUID()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(first, forKey: .first)
        try container.encode(last, forKey: .last)
    }
}
