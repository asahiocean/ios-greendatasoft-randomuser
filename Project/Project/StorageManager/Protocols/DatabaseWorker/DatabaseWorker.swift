import Foundation
import CoreData.NSManagedObject

protocol DatabaseWorker {
    typealias StatusType = ((Status._type) -> ())
    typealias GetDB = ((Database) -> Void)
    dynamic mutating func setDatabase(_ db: Database)
    dynamic mutating func getDatabase(_ result: @escaping GetDB)
    dynamic func statusDatabase(_ status: Status, result: @escaping StatusType)
}
