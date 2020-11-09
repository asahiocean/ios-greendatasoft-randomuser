import Foundation

extension Dob {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Dob.self, from: data)
        self.init(date: me.date, age: me.age)
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
        date: String?? = nil,
        age: Int?? = nil
    ) -> Dob {
        return Dob(
            date: date ?? self.date,
            age: age ?? self.age
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
