import Foundation

extension Picture {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Picture.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        large: String? = nil,
        medium: String? = nil,
        thumbnail: String? = nil
    ) -> Picture {
        return Picture(
            large: large ?? self.largeUrl,
            medium: medium ?? self.mediumUrl,
            thumbnail: thumbnail ?? self.thumbnailUrl
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
