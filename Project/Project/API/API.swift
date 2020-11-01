import Foundation

struct API: GET, POST {    
    
    static let shared = API()
    
    dynamic func loadRandomuser(_ completion: @escaping (Database) throws -> Void) {
        self.get(.dataTask, URLRequest(url: URL(string: Url.get.rawValue.urlValid)!), { data -> Void in
            //MARK: хз почему через iflet пролетала нулевая data
            if (data?.count ?? 0) > 0, let data = data {
                let d = JSONDecoder()
                d.keyDecodingStrategy = .convertFromSnakeCase
                d.dateDecodingStrategy = .iso8601
                StorageManager.shared.accept(data)
                try? completion(try d.decode(Database.self, from: data))
            }
        })
    }
    private init() { }
}
