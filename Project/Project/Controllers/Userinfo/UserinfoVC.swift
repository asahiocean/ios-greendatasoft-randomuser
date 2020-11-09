import UIKit
import Nuke
// import SimpleImageViewer

class UserinfoVC: UIViewController {
     
    static var nibName: String { String(describing: self ) }
    
    @IBOutlet weak var photo: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let configuration = ImageViewerConfiguration { config in
//            config.imageView = photo
//        }
//
//        let imageViewerController = ImageViewerController(configuration: configuration)
//
//        present(imageViewerController, animated: true)
//        
    }
}
