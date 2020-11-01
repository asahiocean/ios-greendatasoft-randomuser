//
//  ViewController.swift
//  Project
//
//  Created by Sergey Fedotov on 27.10.2020.

import UIKit
import CoreData
import EGOCache
import FontAwesome_swift

class NotebookVC: UIViewController {
    
    var tableView: UITableView!
    var persons: Database? {
        didSet {
            DispatchQueue.main.async { [self] in
                tableView.reloadData()
            }
        }
    }
    
    public var appDelegate: AppDelegate!
    public var context: NSManagedObjectContext!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notebook"
        view.layer.backgroundColor = #colorLiteral(red: 0.0170332063, green: 0.2035003901, blue: 0.1973262429, alpha: 1)
        _storageManagerSetup()
        _navigationBarSetup()
        _tableViewSetup()
        _loadRandomuser()
    }    
}
