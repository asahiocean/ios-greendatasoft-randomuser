import UIKit

extension NotebookVC {
    fileprivate func cacheRemoveKey(_ allKeys: [String], _ completion: @escaping (String,Any) -> Void) {
        for timestamp in allKeys.indices {
            StorageManager.shared.cache.remove(forKey: allKeys[timestamp])
            completion("deleted","\(allKeys[timestamp])")
            if timestamp == allKeys.indices.dropLast().count {
                completion("exist","\(allKeys[timestamp])")
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
            var params: [String:Any] = [:] {
                didSet {
                    print(params.count)
                }
            }

            let clearCache = BlockOperation {
                guard let keys = StorageManager.shared.cache.allKeys() as? [String] else { return }
                func find(_ prefix: String) -> [String] { keys.filter { obj in obj.hasPrefix(prefix)}}
                let jsondata = find("jsondata").sorted()
                cacheRemoveKey(jsondata, { key,value in
                    params.updateValue(value, forKey: key)
                })
            }
            
            operationQueue.addOperations([clearCache], waitUntilFinished: true)
            
            operationQueue.addBarrierBlock {
                DispatchQueue(label: "\(type(of: self)).API.shared.post", qos: .utility).async {
                    let rqst = URLRequest(url: URL(string: Url.post.rawValue.urlValid)!)
                    API.shared.post(.contentType, rqst, params,{ data in
                        print("✅", String(data: data, encoding: .utf8) ?? "")
                    })
                }
            }
        }
        alertController.addAction(clearCache)
        // - - - - - -
        
        present(alertController, animated: true) {
            alertController.exitIntuitive(vc: self)
        }
    }
    
    func _navigationBarLeftButton(size: CGSize, textColor: UIColor?) {
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
