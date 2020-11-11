import Foundation
import Dispatch
import Nuke

extension Decodable {
    static func map(JSONString:String) -> Self? {
        do {
            return try jsonDecoder().decode(Self.self, from: Data(JSONString.utf8))
        } catch let error {
            print(error)
            return nil
        }
    }
}

final class Handler: SetData, JSON {
    private var storage: StorageManager!

    public static let shared = Handler()
    
    private func createWeatherObjectWith<T: Decodable>(json: Data, Object:T.Type ,completion: @escaping (_ data: T?, _ error: Error?) -> Void) {
        do {
            let weather = try jsonDecoder().decode(T.self, from: json)
            return completion(weather, nil)
        } catch let error {
            return completion(nil, error)
        }
    }

    internal func jsonData(_ data: Data, completion: ((Any) -> (Void))?) {
        DispatchQueue.main.async {
            if let db = try? jsonDecoder().decode(Database.self, from: data) {
                for i in db.results.indices {
                    let pic = db.results[i].picture
                    API.loadImage(pic.largeUrl, { value in
                        if let image = value {
                            db.results[i].picture.image = image
                        }
                    })
                    if i == db.results.endIndex - 1 {
                        self.storage.setdb(db.results, db.info)
                    }
                }
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let jsonData = try? JSONSerialization.data(withJSONObject: json) {
                        let user = Database.map(JSONString: String(data: jsonData, encoding: .utf8)!)
                        print(user ?? "")
                    }
                    
                } catch let error as NSError {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
    
    fileprivate func gettingBackup(completion: (() -> (Void))?) {
        let quene = DispatchQueue(label: "com.gettingBackup", qos: .background)
        let group = DispatchGroup()
        
        group.enter()
        quene.async(group: group, execute: { [self] in
        if storage.database == nil {
            if let keys = storage.cache.allKeys() as? [String], keys.isEmpty == false {
                for key in keys where key.hasPrefix(keyJsonData) {
                    if let data = storage.cache.data(forKey: key) {
                        jsonData(data, completion: { _ in group.leave() })
                    }
                }
            } else {
                storage.getCoreData(JsondataEntity.self, output: { [self] array -> Void in
                    if let last = array.last, let data = last.jsonData {
                        jsonData(data, completion: { _ in group.leave() })
                    } else {
                        group.leave()
                    }
                })
            }
        } else {
            group.leave()
        }
        })
        group.notify(queue: quene, execute: {
            if let task = completion { task() }
        })
    }
        
    func setdata(_ data: Data?) {
        if let data = data {
            gettingBackup(completion: { [self] in
                jsonData(data, completion: nil)
            })
        } else {
            gettingBackup(completion: nil)
        }
    }
    private init() {
        self.storage = StorageManager.shared
    }
}
