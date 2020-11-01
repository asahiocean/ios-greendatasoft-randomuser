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
        var arrayContrainer = try decoder.unkeyedContainer()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try arrayContrainer.decode([Results].self)
        info = try arrayContrainer.decode(Info.self)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
        try container.encode(info, forKey: .info)
    }
}
