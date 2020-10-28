//
//  ViewController.swift
//  Project
//
//  Created by Sergey Fedotov on 27.10.2020.

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let CoreDataDB = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.backgroundColor = #colorLiteral(red: 0.0170332063, green: 0.2035003901, blue: 0.1973262429, alpha: 1)
        
        let indicator = UIActivityIndicatorView()
        indicator.center = view.center
        indicator.style = .large
        indicator.color = #colorLiteral(red: 0.8300367594, green: 0.711122334, blue: 0.5887681246, alpha: 1)
        indicator.startAnimating()
        view.addSubview(indicator)
        
        //CoreDataDB
        API.get(method: .GET, url: URLs.get, completion: { data -> Void in
            if let data = data {
                do {
                    // print(try JSONSerialization.jsonObject(with: data, options: []))
                    // допустим, необходимо доставить отчет серверу, что были получены какие-то данные
                    var parameters: [String:Any] = [:]
                    parameters.updateValue(
                        data.count, forKey: "datacount")
                    API.post(.POST, URLs.post, parameters)
                } catch {
                    print(error.localizedDescription)
                }
            }
        })
    }
}
