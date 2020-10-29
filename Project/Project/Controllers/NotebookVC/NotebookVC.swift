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
    var persons = [Welcome]()
    
    private(set) var context: NSManagedObjectContext! // CoreData context
    private var fetchRequest: NSFetchRequest<NSFetchRequestResult>!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notebook"
        view.layer.backgroundColor = #colorLiteral(red: 0.0170332063, green: 0.2035003901, blue: 0.1973262429, alpha: 1)
        context = appDelegate.persistentContainer.viewContext
        
        navigationBarSetup()
        tableViewConfig()
    }
        
    fileprivate func sendFetchRequest() {
        fetchRequest = JsonData.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let contextArray = try context.fetch(fetchRequest)
            print("🟢 CONTEXT.COUNT: \(contextArray.count)")
        } catch {
            print(error)
        }
    }
    
    func asdasd<T: NSManagedObject>(type: T.Type, context: NSManagedObjectContext, jsonData: Data, _ completion: (() -> (Void))) {
        DispatchQueue.main.async { [self] in
            let fetchRequest: NSManagedObject = T.init(context: context)
            fetchRequest.setValue(jsonData, forKey: "jsondata")
            DispatchQueue.main.async {
                appDelegate.saveContext()
            }
        }
    }
    
    fileprivate func extractedFunc(jsonData: Data) {
        let contxt = JsonData(context: context)
        contxt.jsondata = jsonData
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sendFetchRequest()
        
        let api: API = API.shared
                        
//        print(api.cache.allKeys().count)

        api.get(method: .GET, url: URLs.get, completion: { [self] data -> Void in
            
            if let data = data {
//                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments); print(json)

                api.cache.setData(data, forKey: "jsondata")
//                print(api.cache.allKeys().count)
                
//                extractedFunc(jsonData: data)
                
                asdasd(type: JsonData.self, context: context, jsonData: data, {
                    sendFetchRequest()
                })
                
                do {
//                    print(try JSONSerialization.jsonObject(with: data, options: []))
//                    // допустим, необходимо доставить отчет серверу, что были получены какие-то данные
//                    var parameters: [String:Any] = [:]
//                    parameters.updateValue(data.count, forKey: "datacount")
//                    API.shared.post(.POST, URLs.post, parameters, completion: { data in
//                        guard let data = data, let answer = String(data: data, encoding: .utf8) else { return }
//                        print("✅ Server confirm: \(answer)")
//                    })
                } catch {
                    print(error.localizedDescription)
                }
            }
        })

    }

}
