import Foundation

extension Result {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Result.self, from: data)
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
        gender: Gender? = nil,
        name: Name? = nil,
        location: Location? = nil,
        email: String? = nil,
        login: Login? = nil,
        dob: Dob? = nil,
        registered: Registered? = nil,
        phone: String? = nil,
        cell: String? = nil,
        id: ID? = nil,
        picture: Picture? = nil,
        nat: String? = nil
    ) -> Result {
        return Result(
            gender: gender ?? self.gender,
            name: name ?? self.name,
            location: location ?? self.location,
            email: email ?? self.email,
            login: login ?? self.login,
            dob: dob ?? self.dob,
            registered: registered ?? self.registered,
            phone: phone ?? self.phone,
            cell: cell ?? self.cell,
            id: id ?? self.id,
            picture: picture ?? self.picture,
            nat: nat ?? self.nat
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
