import Foundation

struct API: GETPOST {
    
    static let shared = API()
    
    static func loadUsers(_ n: Int) {
        let request = URLRequest(url: URL(string: Url.get.rawValue+"\(n)")!)
        Self.get(request, { data,_,_ in Handler.shared.setdata(data) })
    }
    
    static func report(key: String, value: Any) {
        let request = URLRequest(url: URL(string: Url.post.rawValue)!)
        Self.post(.json, request, [key:value])
    }
    
    fileprivate init() { }
}
