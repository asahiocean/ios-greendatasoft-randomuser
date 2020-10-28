import Foundation

extension POST {
    /**
     Ответ сервера о получении
     ~~~
     static func answer(request: URLRequest, completion: @escaping (Data?) -> Void?)  {
         DispatchQueue(label: "POST.answer.utility.queue", qos:.utility).async {
             URLSession.shared.dataTask(with: request) { data, _, _ in
                 if let data = data {
                     completion(data)
                     if let answer = String(data: data, encoding: .utf8) {
                         print(answer)
                     }
                 }
             }.resume()
         }
     }
     ~~~
    */
    static func answer(request: URLRequest, _ completion: @escaping (Data?) -> Void?)  {
        DispatchQueue(label: "POST.answer.utility.queue", qos:.utility).async {
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
