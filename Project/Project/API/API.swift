import UIKit

final class API: GET, POST {
    static func loadRandomUsers(_ n: Int) {
        let urlStr = Url.getUsers.rawValue+"\(n)"
        if let url = URL(string: urlStr) {
            let request: URLRequest = URLRequest(url: url)
            get(request,{ data,_,_ -> Void in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.1, execute: {
                Handler.shared.setdata(data)
            })
            })
        }
    }
    private init() { }
}
