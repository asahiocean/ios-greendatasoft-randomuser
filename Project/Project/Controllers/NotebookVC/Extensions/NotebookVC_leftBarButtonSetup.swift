import UIKit

extension NotebookVC {
    @objc fileprivate func action() {
        let alertController = UIAlertController(
            title: "Дополнительное меню",
            message: .none,
            preferredStyle: .actionSheet)
                
        let clearCache = UIAlertAction(title: "Очистить кэш", style: .destructive) { [self] action -> Void in
            cleanerEntity(entityName: "JsonData", context: context)
        }
        alertController.addAction(clearCache)
                        
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
