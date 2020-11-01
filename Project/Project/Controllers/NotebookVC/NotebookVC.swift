//
//  ViewController.swift
//  Project
//
//  Created by Sergey Fedotov on 27.10.2020.

import UIKit
import CoreData

class NotebookVC: UIViewController {
    
    var persons: Database? { didSet { _databaseServiceFunction() }}
    
    open var appDelegate: AppDelegate!
    open var context: NSManagedObjectContext!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        _storageManagerSetup()
        _loadRandomuser()
        _navigationBarSetup()
        _tableViewSetup()
    }
}
