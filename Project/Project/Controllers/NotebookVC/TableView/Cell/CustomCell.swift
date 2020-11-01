import UIKit.UITableViewCell

public let CustomCellID: String = "CustomCellID"
class CustomCell: UITableViewCell {
    
    @IBOutlet weak var nameStack: UIStackView!
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
            
    required init?(coder aDecoder: NSCoder) {
        if aDecoder == .none {
            fatalError("init(coder:) has not been implemented")
        } else {
            super.init(coder: aDecoder)
            initViews()
        }
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension CustomCell {
    fileprivate func initViews() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
    }
}
