import Foundation

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

struct Database: Codable {
    var results: [Result]
    var info: Info

    private enum CodingKeys: String, CodingKey {
        case results = "results"
        case info = "info"
    }

    public init(results: [Result], info: Info) {
        self.results = results
        self.info = info
    }

    internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decode([Result].self, forKey: .results)
        info = try values.decode(Info.self, forKey: .info)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
        try container.encode(info, forKey: .info)
    }
}
