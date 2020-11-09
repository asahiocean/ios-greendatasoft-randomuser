import Foundation

final class API: GET, POST {
    static func loadRandomUsers(_ n: Int) {
        let urlStr = Url.getUsers.rawValue+"\(n)"
        if let url = URL(string: urlStr) {
            let request: URLRequest = URLRequest(url: url)
            get(request,{ data,_,_ -> Void in
                Handler.shared.setdata(data)
            })
        }
    }
    private init() { }
}
