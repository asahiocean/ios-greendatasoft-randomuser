import Foundation

extension Array where Element == String {
    func prefix(_ str: String) -> [String] { filter { obj in obj.hasPrefix(str)}}
}
