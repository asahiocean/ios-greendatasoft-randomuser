import Foundation

protocol JSON {
    func jsonData(_ data: Data, completion: ((Any) -> (Void))?)
}
