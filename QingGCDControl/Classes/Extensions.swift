//
//  Extensions.swift
//  QingGCDControl
//
//  Created by PeterLin on 2022/9/20.
//

import UIKit

extension UIViewController {
    fileprivate class func fromStoryBoardHelper<T>(storyBoardName: String, storyBoardID: String) -> T {
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: storyBoardID) as! T
        return controller
    }
    
    public func name() -> String {
        return String(describing: self)
    }
    
    public static func fromStoryBoard() -> Self {
        let id = String(describing: self)
        return fromStoryBoardHelper(storyBoardName: "Main", storyBoardID: id)
    }
    
    public func push(vc:UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    public func pop(toRoot: Bool) {
        DispatchQueue.main.async {
            if toRoot {
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    public func popTo(_ vc: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.popToViewController(vc, animated: true)
        }
    }
}
