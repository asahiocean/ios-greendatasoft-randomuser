import Foundation

class API: GET, POST {

    static let shared = API()
    private init(){}
    
    public func loadUsers(_ n: Int) {
        let request = URLRequest(url: URL(string: Url.get.rawValue+"\(n)")!)
        self.get(request, { data,_,_ in Handler.shared.setdata(data) })
    }
    
    public func report(key: String, value: Any) {
        let request = URLRequest(url: URL(string: Url.post.rawValue)!)
        self.post(.contentType, request, [key:value])
    }
}
