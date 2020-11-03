import Foundation

final class Handler: APIData, JSON {
    var jsonDecoder: JSONDecoder!

    public static let shared = Handler()
    
    func apidata(_ data: Data?) {
        if let data = data {
            self.jsonStorageManager(data)
        } else {
            
        }
    }
    private init() { }
}
