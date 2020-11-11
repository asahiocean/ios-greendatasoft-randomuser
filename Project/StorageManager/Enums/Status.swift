import Foundation

enum Status {
    case count
}
extension Status {
    typealias _type = (Any)
    func count(_ value: Status) -> Status { return value }
}
