import UIKit
import Nuke
import FontAwesome_swift

class CustomCell: UITableViewCell {
    static var id: String { String(describing: self )}
    static var nib: UINib { UINib(nibName: id, bundle: nil )}
    @IBOutlet weak var view: UIView!
    
    public var idname: UUID?
    public var gender: String?
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var phoneIcon: FontAwesomeImageView!
        
//    override init(style: CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
    
    func setResult(_ result: Result) {
        idname = result.name.id
        gender = result.name.title
        firstname?.text = result.name.first
        surname?.text = result.name.last
        
        //MARK: Picture Block
        DispatchQueue.main.async {
            let url: String = result.picture.largeUrl
            API.shared.loadImage(url, { image in
                self.photo?.image = image
            })
        }
        phone.text = result.phone
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)

        self.layer.borderWidth = 0.5
        self.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        self.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        
        photo.clipsToBounds = true
        photo.layer.masksToBounds = true
        photo.layer.cornerRadius = photo.bounds.width/2
        photo.layer.borderColor = #colorLiteral(red: 0.2031390071, green: 0.2078698874, blue: 0.2164929211, alpha: 1)
        photo.layer.borderWidth = 2
        
        let n = phone.bounds.height
        let sizeicon = CGSize(width: n, height: n)
        phoneIcon.image = .fontAwesomeIcon(
            name: .phoneAlt,
            style: .solid,
            textColor: #colorLiteral(red: 0.2030032575, green: 0.2080235779, blue: 0.2164820433, alpha: 1),
            size: sizeicon)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
