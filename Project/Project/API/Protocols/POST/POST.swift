import Foundation

protocol POST: class {
    static func post(_ method: Method, _ url: String, _ parameters: [String:Any])
}
