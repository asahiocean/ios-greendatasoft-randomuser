import Foundation
import CoreData.NSManagedObject

protocol DatabaseWorker {
    typealias State = ((Status._type) -> ())
    typealias InfRes = ((_ results: [Results], _ info: Info) -> ())
    var database: Database? { get set }
    dynamic mutating func setdb(results: [Results],info: Info)
    static func statusdb(_ status: Status, state: @escaping State)
}
