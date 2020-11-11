import Foundation

extension Info {
    convenience init(data: Data) throws {
        let me = try jsonDecoder().decode(Info.self, from: data)
        self.init(seed: me.seed, results: me.results, page: me.page, version: me.version)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        seed: String?? = nil,
        results: Int?? = nil,
        page: Int?? = nil,
        version: String?? = nil
    ) -> Info {
        return Info(
            seed: seed ?? self.seed,
            results: results ?? self.results,
            page: page ?? self.page,
            version: version ?? self.version
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
