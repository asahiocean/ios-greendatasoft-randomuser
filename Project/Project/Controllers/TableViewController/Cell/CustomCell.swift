import UIKit
import SimpleImageViewer

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var surname: UILabel!
    
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        config(); #warning("OK")
    }
    
    required init?(coder aDecoder: NSCoder) {
        if aDecoder == .none {
            fatalError("init(coder:) has not been implemented")
        } else {
            super.init(coder: aDecoder)
        }
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension CustomCell {
    fileprivate func config() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
//        autoresizingMask =
//            [.flexibleWidth, .flexibleHeight]
    }
}
