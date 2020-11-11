import Foundation

extension Login {
    convenience init(data: Data) throws {
        let me = try jsonDecoder().decode(Login.self, from: data)
        self.init(uuid: me.uuid, username: me.username, password: me.password, salt: me.salt, md5: me.md5, sha1: me.sha1, sha256: me.sha256)
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
        uuid: String?? = nil,
        username: String?? = nil,
        password: String?? = nil,
        salt: String?? = nil,
        md5: String?? = nil,
        sha1: String?? = nil,
        sha256: String?? = nil
    ) -> Login {
        return Login(
            uuid: uuid ?? self.uuid,
            username: username ?? self.username,
            password: password ?? self.password,
            salt: salt ?? self.salt,
            md5: md5 ?? self.md5,
            sha1: sha1 ?? self.sha1,
            sha256: sha256 ?? self.sha256
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
