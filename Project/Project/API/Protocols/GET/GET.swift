import Foundation

protocol GET: class {
    static func get(method: Method, url: String, completion: @escaping (Data?) -> Void)
}
