//
//  GCDController.swift
//  GCDControl
//
//  Created by PeterLin on 2022/8/30.
//

import UIKit

public class GCDController: NSObject {
    public static let shared = GCDController()
    
    public let group = DispatchGroup()
    
    private override init() {
        super.init()
    }
    
    public func addQueue( _ mission: Void) {
        group.enter()
        mission
        group.wait()
    }
    
}
