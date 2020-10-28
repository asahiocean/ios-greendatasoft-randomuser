//
//  ViewController.swift
//  Project
//
//  Created by Sergey Fedotov on 27.10.2020.

import UIKit
import CoreData

class NotebookVC: UIViewController {
    
    let CoreDataDB = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notebook"
        view.layer.backgroundColor = #colorLiteral(red: 0.0170332063, green: 0.2035003901, blue: 0.1973262429, alpha: 1)
        
        let indicator = UIActivityIndicatorView()
        indicator.center = view.center
        indicator.style = .large
        indicator.color = #colorLiteral(red: 0.8300367594, green: 0.711122334, blue: 0.5887681246, alpha: 1)
        indicator.startAnimating()
        view.addSubview(indicator)
        
        //CoreDataDB
        API.shared.get(method: .GET, url: URLs.get, completion: { data -> Void in
            if let data = data {
//                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//                do {
//                    try context.fetch(JsonData(context: context)
//                    context
//                }
//                catch {
//                    print(error.localizedDescription)
//                }
                do {
                    print(try JSONSerialization.jsonObject(with: data, options: []))
                    // допустим, необходимо доставить отчет серверу, что были получены какие-то данные
                    var parameters: [String:Any] = [:]
                    parameters.updateValue(data.count, forKey: "datacount")
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
