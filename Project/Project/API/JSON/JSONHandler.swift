import Foundation

final class JSONHandler {
    
    static let shared = JSONHandler()
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    func reception(data: Data, completion: @escaping ((Database) throws -> Void)) {
        print("✅ \(type(of: self)).reception.data:", data.count)
        do {
            let usr = try decoder.decode(Database.self, from: data)

            let links = usr.results
            for link in links {
                print(link.name)
            }
        } catch let JSONHandlerReceptionError as NSError {
            print("🔴 JSONHandlerReceptionError:", JSONHandlerReceptionError.localizedDescription)
        }
    }
    
    private init() { }
}
