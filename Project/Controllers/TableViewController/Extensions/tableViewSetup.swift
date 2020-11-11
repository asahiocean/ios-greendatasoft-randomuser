import Foundation
import UIKit.UIActivity

extension TableViewController {
    internal func tableViewSetup() {
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = rowHeight
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.decelerationRate = .fast
        tableView.contentInsetAdjustmentBehavior = .never
        
        let activityView = UIActivityIndicatorView(style: .large)
        tableView.backgroundView = activityView
        activityView.startAnimating()
    }
}
