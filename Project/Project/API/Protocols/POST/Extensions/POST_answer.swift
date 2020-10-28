import Foundation

extension POST {
    /**
     Ответ сервера о получении
     ~~~
     public func answer(request: URLRequest, _ completion: @escaping (Data?) -> Void?)  {
         DispatchQueue.global(qos: .background).async {
             URLSession.shared.dataTask(with: request) { data, _, error in
                 if let data = data {
                     completion(data)
                 } else {
                     completion(nil)
                 }
             }.resume()
         }
     }
     ~~~
    */
    public func answer(request: URLRequest, _ completion: @escaping (Data?) -> Void?)  {
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let data = data {
                    completion(data)
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }
}
