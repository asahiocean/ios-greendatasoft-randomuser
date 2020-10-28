import Foundation

protocol GET {
    func get(method: RequestMethod, url: String, completion: @escaping (Data?) -> Void)
}
