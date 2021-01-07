import Foundation

extension Array where Element == String {
    open func prefix(_ str: String) -> [String] { filter { obj in obj.hasPrefix(str)}}
}
