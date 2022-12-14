//
//  SecondVC.swift
//  QingGCDControl_Example
//
//  Created by PeterLin on 2022/9/20.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import QingGCDControl

class SecondVC: UIViewController {
    private let TAG = String(describing: SecondVC.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LoadingView.shared.show(in: view)
    }
}
