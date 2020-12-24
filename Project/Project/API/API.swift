import Foundation

class API: GET, POST {

    static let shared = API()

    func loadUsers(_ n: Int) {
        let urlStr = Url.get.rawValue+"\(n)"
        if let url = URL(string: urlStr) {
            let request = URLRequest(url: url)
            get(request,{ data,_,_ -> Void in
                DispatchQueue(label: "com.api.load.users", qos: .background).async {
                    Handler.shared.setdata(data)
                }
            })
        }
    }
    public func report(key: String, value: Any) {
        DispatchQueue(label: "com.api.report", qos: .utility).async {
            guard let url = URL(string: Url.post.rawValue) else { return }
            API.shared.post(.contentType, URLRequest(url: url), [key:value])
        }
    }
    private init() { }
}
