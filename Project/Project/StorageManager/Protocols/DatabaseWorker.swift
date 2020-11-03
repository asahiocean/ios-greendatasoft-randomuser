import Foundation
import CoreData.NSManagedObject

protocol DatabaseWorker {
    typealias StatusType = ((Status._type) -> ())
    dynamic mutating func setDatabase(_ db: Database)
    dynamic func getDatabase<T: NSManagedObject>(_ appDelegate: AppDelegate, _ : T.Type, output: (([T]) -> Void)?)
    dynamic func statusDatabase(_ status: Status, result: @escaping StatusType)
}
