import Foundation

extension POST {
    static func answer(request: URLRequest)  {
        DispatchQueue(label: "POST.answer.utility.queue", qos:.utility).async {
            URLSession.shared.dataTask(with: request) { data, _, _ in
                if let data = data {
                    // ответ сервера о получении
                    if let answer = String(data: data, encoding: .utf8){
                        print(answer)
                    }
                }
            }.resume()
        }
    }
}
