import Foundation

struct Info: Codable {
    var seed: String
    var results, page: Int
    var version: String
    
    init(seed: String?, results: Int?, page: Int?, version: String?) {
        self.seed = seed ?? ""
        self.results = results ?? 0
        self.page = page ?? 0
        self.version = version ?? ""
    }

    private enum CodingKeys: String, CodingKey {
        case seed = "seed"
        case results = "results"
        case page = "page"
        case version = "version"
    }

    internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        seed = try values.decode(String.self, forKey: .seed)
        results = try values.decode(Int.self, forKey: .results)
        page = try values.decode(Int.self, forKey: .page)
        version = try values.decode(String.self, forKey: .version)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(seed, forKey: .seed)
        try container.encode(results, forKey: .results)
        try container.encode(page, forKey: .page)
        try container.encode(version, forKey: .version)
    }
}
