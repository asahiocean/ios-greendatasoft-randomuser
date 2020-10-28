import Foundation

final class Parser: ParserDelegate {
    func reception(data: Data) {
        print(data.count)
    }
        
    fileprivate(set) var decoder: JSONDecoder!

    init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
//    let welcome = try decoder.decode(Welcome.self, from: jsonData)
}
