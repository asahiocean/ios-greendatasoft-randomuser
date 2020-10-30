import Foundation

final class JSONHandler {
    
    static let shared = JSONHandler()
    fileprivate var decoder: JSONDecoder!
    
    func reception(data: Data, completion: @escaping ((Database) throws -> Void)) {
        print("✅ \(type(of: self)).reception.data:", data.count)
        do {
            let results = try decoder.decode(Database.self, from: data)
            try? completion(results)
        } catch let JSONHandlerReceptionError as NSError {
            print("🔴 JSONHandlerReceptionError:", JSONHandlerReceptionError.localizedDescription)
        }
    }
    
    private init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
}
