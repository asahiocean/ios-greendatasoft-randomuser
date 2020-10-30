//
//  ViewController.swift
//  Project
//
//  Created by Sergey Fedotov on 27.10.2020.

import UIKit
import CoreData
import EGOCache
import FontAwesome_swift

class NotebookVC: UIViewController, Coredata {
    
    var tableView: UITableView!
//    var persons: [Database] = [Database]()
    
    private(set) var context: NSManagedObjectContext!
    private var fetchRequest: NSFetchRequest<NSFetchRequestResult>!
    private(set) var appDelegate: AppDelegate!
    
    let api: API = API()
                
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notebook"
        view.layer.backgroundColor = #colorLiteral(red: 0.0170332063, green: 0.2035003901, blue: 0.1973262429, alpha: 1)
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        context = appDelegate.persistentContainer.viewContext
        
        navigationBarSetup()
        tableViewConfig()
        
//        sendFetchRequest(appDelegate, JsonData.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        api.get(method: .GET, url: URLs.get, completion: { [self] data -> Void in
            if let jsonData = data {
                api.cache.setData(jsonData,
                                  forKey: "jsondata\(Int(Date().timeIntervalSince1970))", // чтобы найти по hasPrefix
                                  withTimeoutInterval: 604800) // 1 week
                saveContextEntity(appDelegate, JsonData.self, context, "jsondata", jsonData)
                // sendFetchRequest(appDelegate, JsonData.self)
                DispatchQueue(label: "\(type(of: self)).apt.get.persons.background", qos: .background).async {
                    JSONHandler.shared.reception(data: jsonData, completion: { value in
//                        let person = RandomUser(from: <#T##Decoder#>)
                        DispatchQueue.main.async { [self] in
//                            persons.append(value)
                            tableView.reloadData()
                        }
                    })
                }
                do {
//                    print(try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments))
//                    var parameters: [String:Any] = [:]
//                    parameters.updateValue(jsonData.count, forKey: "datacount")
//                    API.shared.post(.POST, URLs.post, parameters) // допустим, необходимо доставить отчет серверу, что были получены какие-то данные
                } catch let apigeterror as NSError {
                    print("🔴 \(type(of: self)).apigeterror:", apigeterror.localizedDescription)
                }
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
