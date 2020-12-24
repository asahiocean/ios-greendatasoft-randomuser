import Foundation

enum Status {
    case count
}
extension Status {
    typealias `type` = (Any)
    func count(_ value: Status) -> Status { return value }
}

protocol DBWorker {
    typealias StatusType = ((Status.type) -> ())
    typealias DBVoid = ((_ db: Database) -> (Void))
    var database: Database? { get set }
    mutating func setdb(_ db: Database)
    func statusdb(_ status: Status, _ completion: @escaping StatusType)
}
