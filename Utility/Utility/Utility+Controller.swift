//
//  Utility+Controller.swift
//  Utility
//
//  Created by 涂育旺 on 2018/2/5.
//  Copyright © 2018年 MYXG. All rights reserved.
//

import UIKit

struct ControllerManager {
    var current: UIViewController?
    
    init() {
        create()
    }
}

extension ControllerManager {
    mutating public func create() {
        
        guard  let rootController = UIApplication.shared.keyWindow?.rootViewController else { return }
        guard case let tabbarController as UITabBarController = rootController else {
            return
        }
         let currentRootViewController = tabbarController.viewControllers![tabbarController.selectedIndex]
        
        self.current = currentRootViewController.navigationController?.topViewController
    }
}

extension Utility {
    
    var cm: ControllerManager {
        return ControllerManager()
    }
    
    
}


