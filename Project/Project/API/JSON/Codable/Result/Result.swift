import Foundation

struct Result: Codable {
    var gender: Gender
    var name: Name
    var location: Location
    var email: String
    var login: Login
    var dob: Dob
    var registered: Registered
    var phone, cell: String
    var id: ID
    var picture: Picture
    var nat: String
    
    private enum CodingKeys: String, CodingKey {
        case gender = "gender"
        case name = "name"
        case location = "location"
        case email = "email"
        case login = "login"
        case dob = "dob"
        case registered = "registered"
        case phone = "phone"
        case cell = "cell"
        case id = "id"
        case picture = "picture"
        case nat = "nat"
    }

    init(gender: Gender, name: Name, location: Location, email: String, login: Login, dob: Dob, registered: Registered, phone: String, cell: String, id: ID, picture: Picture, nat: String) {
        self.gender = gender
        self.name = name
        self.location = location
        self.email = email
        self.login = login
        self.dob = dob
        self.registered = registered
        self.phone = phone
        self.cell = cell
        self.id = id
        self.picture = picture
        self.nat = nat
    }

    internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        gender = try values.decode(Gender.self, forKey: .gender)
        name = try values.decode(Name.self, forKey: .name)
        location = try values.decode(Location.self, forKey: .location)
        email = try values.decode(String.self, forKey: .email)
        login = try values.decode(Login.self, forKey: .login)
        dob = try values.decode(Dob.self, forKey: .dob)
        registered = try values.decode(Registered.self, forKey: .registered)
        phone = try values.decode(String.self, forKey: .phone)
        cell = try values.decode(String.self, forKey: .cell)
        id = try values.decode(ID.self, forKey: .id)
        picture = try values.decode(Picture.self, forKey: .picture)
        nat = try values.decode(String.self, forKey: .nat)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(gender, forKey: .gender)
        try container.encode(name, forKey: .name)
        try container.encode(location, forKey: .location)
        try container.encode(email, forKey: .email)
        try container.encode(login, forKey: .login)
        try container.encode(dob, forKey: .dob)
        try container.encode(registered, forKey: .registered)
        try container.encode(phone, forKey: .phone)
        try container.encode(cell, forKey: .cell)
        try container.encode(id, forKey: .id)
        try container.encode(picture, forKey: .picture)
        try container.encode(nat, forKey: .nat)
    }

}
