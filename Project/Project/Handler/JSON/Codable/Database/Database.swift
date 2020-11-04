import Foundation

struct Database: Codable, Identifiable  {
    var results: [Results]
    var info: Info
    var id: UUID
    
    static func ==(lhs: Database, rhs: Database) -> Bool {
        return lhs.results == rhs.results && lhs.info == rhs.info
    }

    private enum CodingKeys: String, CodingKey {
        case results = "results"
        case info = "info"
    }

    public init(results: [Results], info: Info) {
        self.results = results
        self.info = info
        self.id = UUID()
    }

    internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decode([Results].self, forKey: .results)
        info = try values.decode(Info.self, forKey: .info)
        id = UUID()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
        try container.encode(info, forKey: .info)
    }
}
