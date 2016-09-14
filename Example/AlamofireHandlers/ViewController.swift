//
//  ViewController.swift
//  AlamofireHandlers
//
//  Created by Omer Levi Hevroni on 07/11/2016.
//  Copyright (c) 2016 Omer Levi Hevroni. All rights reserved.
//
import UIKit
import AlamofireHandlers
import RxSwift

class ViewController: UIViewController {
    fileprivate let bag : DisposeBag = { return DisposeBag() }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let manager = DelegatingManager(handler: AlamofireHandler())
        manager.request(.GET, "https://httpbin.org/headers").subscribeNext { result in
            print(result.serializeString())
        }.addDisposableTo(bag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
