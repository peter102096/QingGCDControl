//
//  LoadingView.swift
//  NTUGeneBox
//
//  Created by PeterLin on 2021/10/14.
//

import UIKit
import JGProgressHUD

public class LoadingView: NSObject {
    public static let shared: LoadingView = LoadingView()
    
    private let hud = JGProgressHUD()
    
    private override init() {
        hud.textLabel.text = "Loading"
    }
    
    public func show(_ str: String = "Loading", in view: UIView) {
        hud.textLabel.text = str
        DispatchQueue.main.async {
            self.hud.show(in: view)
        }
    }
    
    public func dismiss() {
        DispatchQueue.main.async {
            self.hud.dismiss(animated: true)
        }
    }
    
    func updateProgress(progress: Double) {
        print("progress : \(progress)")
        let progressString = String(format: "%.1f", progress*100)
        print("\(progressString)%")
        DispatchQueue.main.async {
            self.hud.textLabel.text = "\(progressString)%"
        }
    }

}
