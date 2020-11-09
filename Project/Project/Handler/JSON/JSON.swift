import Foundation

protocol JSON {
    var jsonDecoder: JSONDecoder! { get }
    func jsonData(_ data: Data, _ completion: @escaping (Any) -> (Void))
}
extension JSON {
    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy" // ДД.ММ.ГГГГ
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }
}
