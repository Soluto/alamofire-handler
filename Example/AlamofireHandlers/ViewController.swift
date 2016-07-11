//
//  ViewController.swift
//  AlamofireHandlers
//
//  Created by Omer Levi Hevroni on 07/11/2016.
//  Copyright (c) 2016 Omer Levi Hevroni. All rights reserved.
//
import UIKit
import AlamofireHandlers

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let manager = DelegatingManager(handler: AlamofireHandler())
        manager.request(.GET, "https://httpbin.org/headers").then { (result) -> Bool in
            print(result.serializeString())
            return true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

