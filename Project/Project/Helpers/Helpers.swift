import Foundation
import UIKit.UIScreenMode

//MARK: TableViewController Config
var rowHeight: CGFloat = UIScreen.main.bounds.height/10
var estimatedRowHeight: CGFloat = UIScreen.main.bounds.height/10

let updaterQueue = DispatchQueue(label: "updater.queue")
let updaterGroup = DispatchGroup()
