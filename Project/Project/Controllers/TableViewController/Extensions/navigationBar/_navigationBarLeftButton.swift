import UIKit
import FontAwesome_swift

extension TableViewController {
    
    @objc fileprivate func action() {
        let alert = UIAlertController(title: "Дополнительное меню", message: .none, preferredStyle: .actionSheet)
        
        let clearCache = UIAlertAction(title: "Очистить кэш", style: .destructive) { [weak self] action -> Void in
            
            var parameters: [String:Any] = [:]
            
            if let keys = self?.storage.cache.allKeys() as? [String] {
                for key in keys where key.hasPrefix(jsonDataKey)  {
                    self?.storage.cache.remove(forKey: key)
                    parameters.updateValue(key, forKey: "deleted")
                    guard key == keys.last else { return }
                    API.report(key: parameters.map({$0}).description, value: parameters.map({$1}).description)
                }
                keys.forEach { (item) -> Void in
                    switch item.hasPrefix(jsonDataKey) {
                    case true:
                        self?.storage.getCoreData(JsondataEntity.self, output: { (dbs) in
                            switch dbs.isEmpty {
                            case true:
                                break
                            default:
                                let alert = UIAlertController(title: "Кэш успешно очищен!", message: "", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self?.present(alert, animated: true)
                            }
                        })
                    default:
                        break
                    }
                }
            }
        }
        alert.addAction(clearCache)
        
        present(alert, animated: true) {
            alert.dismiss(animated: true, completion: {
                NSLog("\(String(describing: alert)) dismiss")
            })
        }
    }
    
    func navigationBar_left_button(size: CGSize, textColor: UIColor?) {
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
