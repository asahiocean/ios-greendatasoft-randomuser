import Foundation

extension Array where Element == String {
    public func prefix(_ str: String) -> [String] { filter { obj in obj.hasPrefix(str)}}
}
