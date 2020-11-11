import Foundation

final class API: GET, POST {
    public static func loadRandomUsers(_ n: Int) {
        let urlStr = Url.getUsers.rawValue+"\(n)"
        if let url = URL(string: urlStr) {
            let request: URLRequest = URLRequest(url: url)
            get(request,{ data,_,_ -> Void in
                DispatchQueue(label: "com.loadRandomUsers", qos: .background, attributes: .concurrent).async {
                    Handler.shared.setdata(data)
                }
            })
        }
    }
    public static func report(key: String, value: Any) {
        DispatchQueue(label: "com.api.report", qos: .utility).async {
            if let url = URL(string: Url.post.rawValue) {
                post(.contentType, URLRequest(url: url), [key:value])
            }
        }
    }
    private init() { }
}
