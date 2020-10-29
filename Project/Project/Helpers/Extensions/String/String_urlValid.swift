import Foundation

extension String {
    /**
    Валидация url
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
