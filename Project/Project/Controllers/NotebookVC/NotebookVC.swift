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
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var appDelegate: AppDelegate!
    var context: NSManagedObjectContext!
    var coredata: Coredata!
    
    let api: API = API()
                
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notebook"
        view.layer.backgroundColor = #colorLiteral(red: 0.0170332063, green: 0.2035003901, blue: 0.1973262429, alpha: 1)
        
        coreDataSetup()
        navigationBarSetup()
        tableViewConfig()
        
        coredata.getObject(appDelegate, JsonData.self)
        
        api.get(method: .GET, url: URLs.get, completion: { [self] data -> Void in
            if let jsonData = data {
                api.cache.setData(jsonData, forKey: "jsondata\(Int(Date().timeIntervalSince1970))", withTimeoutInterval: 604800) // 1 week
                coredata.saveObject(appDelegate, JsonData.self, context, "jsondata", jsonData)
                coredata.getObject(appDelegate, JsonData.self)
                DispatchQueue.global(qos: .background).async {
                    JSONHandler.shared.reception(data: jsonData, completion: { [self] value in
                            persons = value
                    })
                }
                //API.shared.post(.POST, URLs.post, parameters) // допустим, необходимо доставить отчет серверу, что были получены какие-то данные
            }
        })
    }
}
