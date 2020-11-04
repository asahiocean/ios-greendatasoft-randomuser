import Foundation
import CoreData.NSManagedObject

protocol DatabaseWorker {
    typealias State = ((Status._type) -> ())
    typealias DBV = ((Database) -> ())
    dynamic mutating func setDatabase(_ db: Database)
    dynamic mutating func getDatabase(_ db: @escaping DBV)
    dynamic func statusDatabase(_ status: Status, state: @escaping State)
}
