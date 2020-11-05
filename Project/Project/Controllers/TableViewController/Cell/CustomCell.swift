import UIKit
import SimpleImageViewer

class CustomCell: UITableViewCell {
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: identifier, bundle: nil) }

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var surname: UILabel!

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
