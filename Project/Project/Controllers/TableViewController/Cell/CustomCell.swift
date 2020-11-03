import UIKit

public let cellID: String = "CustomCell"
class CustomCell: UITableViewCell {

    @IBOutlet var view: UIView?
    @IBOutlet var firstname: UILabel?
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension CustomCell {
    fileprivate func config() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
    }
}
