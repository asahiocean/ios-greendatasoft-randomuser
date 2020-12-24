import Foundation

class API: GET, POST {

    static let shared = API()
    private let handler = Handler.shared

    public func loadUsers(_ n: Int) {
        DispatchQueue(label: "com.api.load.users", qos: .background).async { [self] in
            let request = URLRequest(url: URL(string: Url.get.rawValue+"\(n)")!)
            get(request, { data,_,_ in handler.setdata(data) })
        }
    }
    public func report(key: String, value: Any) {
        DispatchQueue(label: "com.api.report", qos: .utility).async {
            let request = URLRequest(url: URL(string: Url.post.rawValue)!)
            self.post(.contentType, request, [key:value])
        }
    }
    private init() { }
}
