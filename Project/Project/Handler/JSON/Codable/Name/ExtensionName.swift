import Foundation

extension Name {
    convenience init(data: Data) throws {
        let me = try jsonDecoder().decode(Name.self, from: data)
        self.init(title: me.title, first: me.first, last: me.last)
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
        title: String?? = nil,
        first: String?? = nil,
        last: String?? = nil
    ) -> Name {
        return Name(
            title: title ?? self.title,
            first: first ?? self.first,
            last: last ?? self.last
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

