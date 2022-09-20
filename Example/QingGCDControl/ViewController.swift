//
//  ViewController.swift
//  QingGCDControl
//
//  Created by PeterLin on 09/16/2022.
//  Copyright (c) 2022 PeterLin. All rights reserved.
//

import UIKit
import QingGCDControl
import IQKeyboardManagerSwift

class ViewController: UIViewController {
    let TAG = String(describing: ViewController.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("\(TAG) \(GCDController.shared.version)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func nextBtnAction(_ sender: Any) {
        let vc = SecondVC.fromStoryBoard()
        push(vc: vc)
    }
}
