import UIKit

final class API: GET, POST {
    public static let shared = API()

    func loadRandomUsers(_ n: Int) {
        if let url = URL(string: Url.getUsers.rawValue+"\(n)") {
            self.get(URLRequest(url: url),{ data,_,_ -> Void in
                Handler.shared.apidata(data)
            })
        }
    }
    private init() { }
}
