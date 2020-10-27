//
//  ViewController.swift
//  Project
//
//  Created by Sergey Fedotov on 27.10.2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.backgroundColor = #colorLiteral(red: 0.0170332063, green: 0.2035003901, blue: 0.1973262429, alpha: 1)
        
        // Test for Bitrise + TestFlight (2)
        let indicator = UIActivityIndicatorView()
        indicator.center = view.center
        indicator.style = .large
        indicator.color = #colorLiteral(red: 0.8300367594, green: 0.711122334, blue: 0.5887681246, alpha: 1)
        indicator.startAnimating()
        view.addSubview(indicator)
    }
}

