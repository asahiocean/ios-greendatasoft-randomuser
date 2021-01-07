import UIKit
import FontAwesome_swift

extension TableViewController {
    
    @objc fileprivate func _action() {
        let alert = UIAlertController(title: "Дополнительное меню", message: .none, preferredStyle: .actionSheet)
        
        let clearCache = UIAlertAction(title: "Очистить кэш", style: .destructive) { [self] action -> Void in
            
            var parameters: [String:Any] = [:]
            
            if let keys = storage.cache.allKeys() as? [String] {
                for key in keys where key.hasPrefix(jsonDataKey)  {
                    storage.cache.remove(forKey: key)
                    parameters.updateValue(key, forKey: "deleted")
                    guard key == keys.last else { return }
                    API.shared.report(key: parameters.map({$0}).description, value: parameters.map({$1}).description)
                }
                keys.forEach {
                    guard $0.hasPrefix(jsonDataKey) else { return }
                    storage.getCoreData(JsondataEntity.self, output: { dbs in
                        if dbs.isEmpty == false {
                            // let alert = UIAlertController(title: "Кэш успешно очищен!", message: "", preferredStyle: .alert)
                            // alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            // self.present(alert, animated: true)
                        }
                    })
                }
            }
        }
        alert.addAction(clearCache)
        
        present(alert, animated: true) { alert.exitIntuitive(vc: self) }
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
            action: #selector(_action))
    }
}
