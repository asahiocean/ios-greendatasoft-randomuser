import UIKit

extension NotebookVC {
    @objc func alertControllerPresenter() {
        let alertController = UIAlertController(
            title: "Дополнительное меню",
            message: .none,
            preferredStyle: .actionSheet)
                
        let clearCache = UIAlertAction(title: "Очистить кэш", style: .destructive) { action in
            
        }
        alertController.addAction(clearCache)
                        
        present(alertController, animated: true) {
            alertController.exitIntuitive(vc: self)
        }
    }
}
