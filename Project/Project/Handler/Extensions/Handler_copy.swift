import Foundation

extension Handler: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any { self }
}
