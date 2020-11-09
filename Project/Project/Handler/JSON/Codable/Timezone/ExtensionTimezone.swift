import Foundation

extension Timezone {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Timezone.self, from: data)
        self.init(offset: me.offset, descriptionTimezone: me.descriptionTimezone)
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
        offset: String? = nil,
        descriptionTimezone: String? = nil
    ) -> Timezone {
        return Timezone(
            offset: offset ?? self.offset,
            descriptionTimezone: descriptionTimezone ?? self.descriptionTimezone
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
