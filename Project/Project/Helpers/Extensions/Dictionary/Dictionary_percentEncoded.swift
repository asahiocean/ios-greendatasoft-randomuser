import Foundation

extension Dictionary {
    /**
    ~~~
    func percentEncoded() -> Data? {
        return map { key, value in
            let escKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escKey + "=" + escValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
    ~~~
    */
    func percentEncoded() -> Data? {
        return map { key, value in
            let escKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escKey + "=" + escValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}
