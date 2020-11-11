import Foundation

protocol DatabaseWorker {
    typealias State = ((Status._type) -> ())
    typealias InfRes = ((_ results: [Results], _ info: Info) -> ())
    var database: Database? { get set }
    mutating func setdb(_ results: [Results], _ info: Info)
    func statusdb(_ status: Status, state: @escaping State)
}
