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
    var fetchingMore = false
    var persons: Database? {
        didSet {
            DispatchQueue.main.async { [self] in
                tableView.reloadData()
            }
        }
    }
    var featchingMore = false
    /*
     storage.cache.setData(jsondata, forKey: "jsondata\(Int(Date().timeIntervalSince1970))", withTimeoutInterval: 2592000) // 1 month
     storage.saveObject(appDelegate, JsonData.self, context, "jsondata", jsondata)
     */
    
    var appDelegate: AppDelegate!
    var context: NSManagedObjectContext!
    var storage: StorageManager!    
    
    func loadRandomuser() {
        API.shared.loadRandomuser({ [self] db -> Void in
            if persons == nil {
                persons = db
            } else {
                let results = db.results
                persons?.results.append(contentsOf: results)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notebook"
        view.layer.backgroundColor = #colorLiteral(red: 0.0170332063, green: 0.2035003901, blue: 0.1973262429, alpha: 1)
        storageManagerSetup()
        navigationBarSetup()
        tableViewSetup()
        loadRandomuser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension NotebookVC {
    
    func loadMoreData() {
            if !fetchingMore {
                fetchingMore = true
                DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
                    // Fake background loading task for 2 seconds
//                    sleep(2)
                    // Download more data here
                    DispatchQueue.main.async { [self] in
                        tableView.reloadData()
                        fetchingMore = false
                    }
                })
            }
        }

        
    func beginBatchFetch() {
        fetchingMore = true
        print("beginBatchFetch!")
        
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [self] in
            print("LOAD!!!")
//            loadRandomuser()
            fetchingMore = false
        })
    }
}
