import UIKit
import FontAwesome_swift

extension NotebookVC {
    fileprivate func cacheRemoveKey(_ allKeys: [String], _ completion: @escaping ([String:Any]) throws -> Void) {
        var params: [String:Any] = [:]
        for timestamp in allKeys.indices {
            StorageManager.shared.cache.remove(forKey: allKeys[timestamp])
            params.updateValue(allKeys[timestamp], forKey: "deleted")
            if timestamp == allKeys.indices.dropLast().count {
                params.updateValue(allKeys[timestamp], forKey: "exist")
                try? completion(params)
            }
        }
    }
    
    @objc fileprivate func action() {
        let alert = UIAlertController(
            title: "Дополнительное меню",
            message: .none,
            preferredStyle: .actionSheet)
        
        // - - - - - -
        let clearCache = UIAlertAction(title: "Очистить кэш", style: .destructive) { [self] action -> Void in
            
            var parameters: [String:Any] = [:]

            guard let keys = StorageManager.shared.cache.allKeys() as? [String] else { return }
            cacheRemoveKey(keys.prefix("jsondata").sorted(), { array in
                for (key,value) in array {
                    parameters.updateValue(value, forKey: key)
                }
            })
            
            let request = URLRequest(url: URL(string: Url.post.rawValue.urlValid)!)
            API.shared.post(.contentType, request, parameters,{ data in
                print("✅", String(data: data, encoding: .utf8) ?? "")
            })
        }
        alert.addAction(clearCache)
        // - - - - - -
        
        present(alert, animated: true) { alert.exitIntuitive(vc: self) }
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
