import Foundation

final class JSONHandler {
    
    static let shared = JSONHandler()
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func reception(data: Data) {
        print(data)
        do {
            let infoString = try decoder.decode(Welcome.self, from: data)
            print(infoString)
        } catch let error as NSError {
            print("\(type(of: self)) docatchError: ", error.localizedDescription)
        }
    }
    
    private init() {
        print("[✅] \(type(of: self)): INIT")
    }
}
