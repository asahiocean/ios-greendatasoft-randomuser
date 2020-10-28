import Foundation

extension String {
    /**
    ~~~
    extension String {
        public var urlValid: String {
            self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
        }
    }
    ~~~
    */
    public var urlValid: String {
        self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
}
