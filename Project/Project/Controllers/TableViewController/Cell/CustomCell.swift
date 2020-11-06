import UIKit
import Nuke
import FontAwesome_swift

class CustomCell: UITableViewCell {
    static var identifier: String {String(describing:self)}
    static var nib: UINib {UINib(nibName:identifier,bundle:nil)}
    @IBOutlet weak var view: UIView!

    public var idname: UUID?
    public var gender: String?
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var imageViewPhoto: UIImageView!
    public var idpic: UUID?
    public var urlPackPhoto: [String] = []
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var phoneIcon: FontAwesomeImageView!
    
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        _initViewConfig()
        _imageViewPhotoConfig()        
        _phoneIconConfig()
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
