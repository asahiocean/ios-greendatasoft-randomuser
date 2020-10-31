import Foundation

struct Database: Codable  {
    var results: [Results]
    var info: Info

    private enum CodingKeys: String, CodingKey {
        case results = "results"
        case info = "info"
    }

    public init(results: [Results], info: Info) {
        self.results = results
        self.info = info
    }

    internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decode([Results].self, forKey: .results)
        info = try values.decode(Info.self, forKey: .info)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
        try container.encode(info, forKey: .info)
    }
}
