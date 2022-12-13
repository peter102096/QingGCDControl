//
//  APISubclass.swift
//  QingGCDControl_Example
//
//  Created by PeterLin on 2022/12/13.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import QingGCDControl

class APISubclass: API {
    public static let shared = APISubclass()
    
    private override init() {
        super.init()
    }
    
    func login() {
        
    }
}
