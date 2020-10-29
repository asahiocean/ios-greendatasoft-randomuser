import UIKit

class NotebookCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.backgroundColor = UIColor.systemRed.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
