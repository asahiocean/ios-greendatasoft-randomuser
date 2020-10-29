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
    
    //MARK: CoreData
    var context: NSManagedObjectContext!
    var dataController: AppDelegate!
                
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notebook"
        view.layer.backgroundColor = #colorLiteral(red: 0.0170332063, green: 0.2035003901, blue: 0.1973262429, alpha: 1)
        
        navigationBarSetup()
        tableViewConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let api: API = API.shared
        
        // Инициализация CoreData происходит только в основном потоке
        dataController = (UIApplication.shared.delegate as? AppDelegate)
        context = dataController.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = JsonData.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let jsonDataArray = try self.context.fetch(fetchRequest)
            print("jsonDataArray.count: \(jsonDataArray.count)")
            
            // self.cleanerEntity(entityName: "JsonData")
        } catch {
            print(error)
        }
                        
        print(api.cache.allKeys().count)

        API.shared.get(method: .GET, url: URLs.get, completion: { data -> Void in
                    
            if let data = data {
                api.cache.setData(data, forKey: "jsondata")
                print(api.cache.allKeys().count)
                
                let context = JsonData(context: self.context)
                context.jsondata = data
                DispatchQueue.main.async {
                    // Сохранение только в основном потоке!
                    self.dataController.saveContext()
                }

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
