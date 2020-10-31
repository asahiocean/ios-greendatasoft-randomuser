import Foundation

final class JSONHandler {
    
    static let shared = JSONHandler()
    fileprivate var decoder: JSONDecoder!
    
    func reception(_ data: Data, _ completion: @escaping ((Database) throws -> Void)) {
        print("-> \(type(of: self)) reception data:", data.count)
        do {
            let db = try decoder.decode(Database.self, from: data)
            try? completion(db)
            print("<- \(type(of: self)): success end of session")
        } catch let error as NSError {
            print("🔴 \(type(of: self)): reception error", error.localizedDescription)
        }
    }
    
    private init() {
        print("-> \(type(of: self)): start of session")
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
}
