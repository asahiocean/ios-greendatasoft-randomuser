//
//  ViewController.swift
//  Project
//
//  Created by Sergey Fedotov on 27.10.2020.

import UIKit

class NotebookVC: UIViewController {
        
    static public var persons: Database? { didSet {
        print(persons?.results.count)
    }}
        
    override func viewDidLoad() {
        super.viewDidLoad()
        _loadRandomUsers()
        _tableViewSetup()
        _navigationBarSetup()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
