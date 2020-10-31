import UIKit

extension NotebookVC {
    fileprivate func cacheRemoveKey(_ allKeys: [String], _ completion: @escaping ([String:Any]) throws -> Void) {
        var params: [String:Any] = [:] // for post request
        for timestamp in allKeys.indices {
            StorageManager.shared.cache.remove(forKey: allKeys[timestamp])
            params.updateValue("deleted", forKey: "\(allKeys[timestamp])")
            if timestamp == allKeys.indices.dropLast().count {
                params.updateValue("exist", forKey: "\(allKeys[timestamp])")
                try? completion(params)
            }
        }
    }
    
    @objc fileprivate func action() {
        let alertController = UIAlertController(
            title: "Дополнительное меню",
            message: .none,
            preferredStyle: .actionSheet)
        
        // - - - - - -
            
        let clearCache = UIAlertAction(title: "Очистить кэш", style: .destructive) { [self] action -> Void in

            let operationQueue = OperationQueue()
            var params: [String:Any] = [:] // for post request

            let clearCache = BlockOperation {
                guard let keys = StorageManager.shared.cache.allKeys() as? [String] else { return }
                func find(_ prefix: String) -> [String] { keys.filter { obj in obj.hasPrefix(prefix)}}
                let jsondata = find("jsondata").sorted()
                cacheRemoveKey(jsondata, { arr in
                    print(arr.map({$0}))
                    params.updateValue(arr, forKey: "jsondata")
                })
            }

            operationQueue.addOperations([clearCache], waitUntilFinished: true)
            
            operationQueue.addBarrierBlock {
                
                print(params.count)
                
                DispatchQueue(label: "\(type(of: self)).API.shared.post", qos: .utility).async {
                    let req = URLRequest(url: URL(string: Url.post.rawValue.urlValid)!)
                    API.shared.post(.contentType, req, params, { req in
                        API.shared.get(.dataTask, req, { data in
                            if let data = data {
                                print("✅", String(data: data, encoding: .utf8) ?? "")
                            }
                        })
                    })
                }
            }
            
//            cleanerEntity(entityName: "JsonData", context: context)
//            DispatchQueue(label: "\(type(of: self)).cache.flush.report.utility", qos: .utility).async {
//                if let allKeys = (StorageManager.shared.cache.allKeys() as? [String]) {
//                    let jsondata = allKeys.sorted().filter { obj in
//                        obj.hasPrefix("jsondata")
//                    }
//                    var parameters: [String:Any] = [:] // for post request
//                    for timestamp in jsondata.indices {
//                        parameters.updateValue("deleted", forKey: "\(jsondata[timestamp])")
//                        StorageManager.shared.cache.remove(forKey: jsondata[timestamp])
//                        if timestamp == jsondata.indices.dropLast().count {
//                            parameters.updateValue("exist", forKey: "\(jsondata[timestamp])")
//                        }
//                    }
//                }
//            }
        }
        alertController.addAction(clearCache)
        // - - - - - -
        
        present(alertController, animated: true) {
            alertController.exitIntuitive(vc: self)
        }
    }
    
    func navigationBarLeftButton(size: CGSize, textColor: UIColor?) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage.fontAwesomeIcon(
                name: .gripLines,
                style: .solid,
                textColor: textColor ?? .white,
                size: size),
            style: .plain,
            target: self,
            action: #selector(action))
    }
}
