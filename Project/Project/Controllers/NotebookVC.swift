//
//  ViewController.swift
//  Project
//
//  Created by Sergey Fedotov on 27.10.2020.

import UIKit
import CoreData
import EGOCache
import FontAwesome_swift

class NotebookVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    private var items = [Welcome]()
    
    //MARK: CoreData
    var context: NSManagedObjectContext!
    var dataController: AppDelegate!
                
    fileprivate func indicator() {
        let indicator = UIActivityIndicatorView()
        indicator.center = view.center
        indicator.style = .large
        indicator.color = #colorLiteral(red: 0.8300367594, green: 0.711122334, blue: 0.5887681246, alpha: 1)
        indicator.startAnimating()
        view.addSubview(indicator)
    }
    
    fileprivate func tableViewSetup() {
        tableView = UITableView()
        tableView.frame = view.frame
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func deleteAllData(entity: String){

    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    fetchRequest.returnsObjectsAsFaults = false

    do {
        let arrUsrObj = try managedContext.fetch(fetchRequest)
        for usrObj in arrUsrObj as! [NSManagedObject] {
            managedContext.delete(usrObj)
        }
       try managedContext.save() //don't forget
        } catch let error as NSError {
        print("delete fail--",error)
      }
    }
    
    @objc func alertControllerPresenter() {
        let alertController = UIAlertController(
            title: "Дополнительное меню",
            message: .none,
            preferredStyle: .actionSheet)
                
        let clearCache = UIAlertAction(title: "Очистить кэш", style: .destructive) { action in
        }
        alertController.addAction(clearCache)
                        
        present(alertController, animated: true) {
            alertController.exitIntuitive(vc: self)
        }
    }
    
    private func navigationBarSetup() {
        let wh = (navigationController?.navigationBar.frame.height ?? (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? .zero)) * 0.9
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage.fontAwesomeIcon(
                name: .gripLines,
                style: .solid,
                textColor: .white,
                size: CGSize(width: wh, height: wh)),
            style: .plain,
            target: self,
            action: #selector(alertControllerPresenter))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notebook"
        view.layer.backgroundColor = #colorLiteral(red: 0.0170332063, green: 0.2035003901, blue: 0.1973262429, alpha: 1)
        
        tableViewSetup()
        indicator()
        
        navigationBarSetup()

//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right",
//                                                                 style: .plain,
//                                                                 target: self,
//                                                                 action: #selector(rightHandAction))
//
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left",
//                                                                style: .plain,
//                                                                target: self,
//                                                                action: #selector(leftHandAction))

        
        let api: API = API.shared
        
        // Инициализация CoreData
        // Подключение происходит только в основном потоке
        dataController = (UIApplication.shared.delegate as? AppDelegate)
        context = dataController.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>! = JsonData.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let jsonDataArray = try self.context.fetch(fetchRequest)
            print("jsonDataArray.count: \(jsonDataArray.count)")
            
            self.deleteAllData(entity: "JsonData")
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

extension NotebookVC {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.bounds.height / 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotebookCell") as? NotebookCell else { fatalError() }
        return cell
    }
}
