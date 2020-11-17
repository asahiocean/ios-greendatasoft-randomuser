import Foundation

extension Database {
    convenience init(data: Data) throws {
        let me = try jsonDecoder().decode(Database.self, from: data)
        self.init(results: me.results, info: me.info)
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
        results: [Result]? = nil,
        info: Info? = nil
    ) -> Database {
        return Database(
            results: results ?? self.results,
            info: info ?? self.info
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
