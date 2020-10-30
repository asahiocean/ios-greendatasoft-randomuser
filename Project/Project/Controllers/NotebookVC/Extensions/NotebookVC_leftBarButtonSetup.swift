import UIKit

extension NotebookVC {
    @objc fileprivate func action() {
        let alertController = UIAlertController(
            title: "Дополнительное меню",
            message: .none,
            preferredStyle: .actionSheet)
        
        // - - - - - -
        let clearCache = UIAlertAction(title: "Очистить кэш", style: .destructive) { [self] action -> Void in
            cleanerEntity(entityName: "JsonData", context: context)
            DispatchQueue(label: "\(type(of: self)).cache.flush.report.utility", qos: .utility).async {
                if let allKeys = (API.shared.cache.allKeys() as? [String]) {
                    let jsondata = allKeys.sorted().filter { obj in
                        obj.hasPrefix("jsondata")
                    }
                    var metaparam: [String:Any] = [:] // for post request
                    for timestamp in jsondata.indices {
                        metaparam.updateValue("deleted", forKey: "\(jsondata[timestamp])")
                        OperationQueue.current?.addBarrierBlock {
                            API.shared.cache.remove(forKey: jsondata[timestamp])
                        }
                        if timestamp == jsondata.indices.dropLast().count {
                            metaparam.updateValue("exist", forKey: "\(jsondata[timestamp])")
                            DispatchQueue(label: "\(type(of: self)).API.shared.post", qos: .utility).async {
                                API.shared.post(.POST, URLs.post, metaparam)
                            }
                        }
                    }
                }
            }
        }; alertController.addAction(clearCache)
        // - - - - - -
        
        present(alertController, animated: true) {
            alertController.exitIntuitive(vc: self)
        }
    }
    func leftBarButtonSetup(size: CGSize, textColor: UIColor?) {
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
