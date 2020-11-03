import Foundation

protocol JSON {
    var jsonDecoder: JSONDecoder! { get }
}
extension JSON {
    var jsonDecoder: JSONDecoder {
        let decod = JSONDecoder()
        decod.keyDecodingStrategy = .convertFromSnakeCase
        decod.dateDecodingStrategy = .iso8601
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy" // ДД.ММ.ГГГГ
        decod.dateDecodingStrategy = .formatted(formatter)
        return decod
    }
}
