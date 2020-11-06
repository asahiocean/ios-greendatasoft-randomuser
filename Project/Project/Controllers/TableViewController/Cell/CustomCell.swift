import UIKit
import Nuke

class CustomCell: UITableViewCell {
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: identifier, bundle:nil)}
    @IBOutlet weak var view: UIView!

    public var idname: UUID?
    public var gender: String?
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var imageViewPhoto: UIImageView!
    public var idpic: UUID?
    public var urlPackPhoto: [String] = []
    
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.layer.borderWidth = 0.5
        self.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        imageViewPhotoConfig()
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension CustomCell {
    fileprivate func imageViewPhotoConfig() {
        imageViewPhoto.clipsToBounds = true
        imageViewPhoto.layer.masksToBounds = true
        imageViewPhoto.layer.cornerRadius = imageViewPhoto.bounds.width / 2
        imageViewPhoto.layer.borderColor = #colorLiteral(red: 0.1601605713, green: 0.1644997299, blue: 0.186186552, alpha: 1)
        imageViewPhoto.layer.borderWidth = 3
        if imageViewPhoto.image?.pngData() == nil {
        let storage = StorageManager.shared
        if let uuidStr = idpic?.uuidString, let imagedata = storage.cache.data(forKey: uuidStr) {
        self.imageViewPhoto.image = UIImage(data: imagedata); #warning("Restore image from cache: OK")
        } else {
            for url in urlPackPhoto where url.hasPrefix("https") {
            ImagePipeline.shared.loadImage(with: URL(string: url)!, { resp in
                switch resp {
                case let .success(result):
                    self.imageViewPhoto.image = result.image
                default:
                    break
                }
            })
            if self.imageViewPhoto.image?.pngData() != nil {
                break
            }}
            }
        }
    }
}
