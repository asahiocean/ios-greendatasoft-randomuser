import Foundation

protocol POST {
    /// в клоужер можно отправить ответ от сервера
    func post(_ method: RequestMethod, _ url: String, _ parameters: [String:Any], completion: @escaping ((Data?) -> Void))
}
