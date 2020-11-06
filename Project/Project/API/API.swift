import UIKit

final class API: GET, POST {
    static func loadRandomUsers(_ n: Int) {
        updaterGroup.enter()
        let urlStr = Url.getUsers.rawValue+"\(n)"
        if let url = URL(string: urlStr) {
            let request: URLRequest = URLRequest(url: url)
            get(request,{ data,_,_ -> Void in
                Handler.shared.apidata(data)
            })
        }
    }
    private init() { }
}
