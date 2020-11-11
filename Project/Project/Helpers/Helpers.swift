import Foundation
import UIKit.UIScreenMode

//MARK: TableViewController Config
public var rowHeight: CGFloat = UIScreen.main.bounds.height/10
public var estimatedRowHeight: CGFloat = UIScreen.main.bounds.height/10

public let updaterQueue = DispatchQueue(label: "updater.queue")
public let updaterGroup = DispatchGroup()

public let keyJsonData: String = "jsonData"
