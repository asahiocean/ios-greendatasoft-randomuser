import Foundation

public final class Database: Codable, Identifiable {
    public var results: [Results]
    public let info: Info
    public let id: UUID

    public static func ==(lhs: Database, rhs: Database) -> Bool {
        return lhs.results == rhs.results && lhs.info == rhs.info
    }
    
    public init(results: [Results], info: Info) {
        self.results = results
        self.info = info
        self.id = .init()
    }

    private enum CodingKeys: String, CodingKey {
        case results = "results"
        case info = "info"
    }

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decode([Results].self, forKey: .results)
        info = try values.decode(Info.self, forKey: .info)
        id = .init()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
        try container.encode(info, forKey: .info)
    }

}
