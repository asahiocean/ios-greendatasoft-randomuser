//
//  ViewController.swift
//  Project
//
//  Created by Sergey Fedotov on 27.10.2020.

import UIKit

class NotebookVC: UIViewController {
    
    var persons: Database?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _loadRandomUsers()
        _tableViewSetup()
        _navigationBarSetup()
    }
}
