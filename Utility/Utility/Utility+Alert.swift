//
//  Utility+Alert.swift
//  Utility
//
//  Created by 涂育旺 on 2018/2/4.
//  Copyright © 2018年 MYXG. All rights reserved.
//

import UIKit

public typealias AlertActionCallback = ((Any) -> Void)?

public protocol AlertActionCompatible {
    func successClick(callback : AlertActionCallback)
    func cancelClick(callback: AlertActionCallback)
}


extension Utility where Base: UIViewController {
    
    @discardableResult
    func show(custom: UIView) -> Utility {
        let alertController = initAlertController()
        alertController.view.addSubview(custom)
        custom.frame = CGRect(x: 0, y: 0, width: snWidth, height: snHeight/1.9)
//        alertController.view.frame = CGRect(x: 0, y: 0, width: snWidth, height: snHeight/1.9);
        base.present(alertController, animated: true, completion: nil)
        print(alertController.view.subviews)
        print(alertController.view.frame)
        
        
        return self
    }
    
    @discardableResult
    func success(_ callback: AlertActionCallback) -> Utility {
        guard case let view as AlertView = base.view.subviews.last else { return self }
        view.successClick(callback: callback)
        return self
    }
    
    @discardableResult
    func cancel(_ callback: AlertActionCallback) -> Utility {
        guard case let view as AlertView = base.view.subviews.last else { return self }
        view.cancelClick(callback: callback)
        return self
    }
}

extension Utility {
    
    fileprivate func initAlertController() -> UIAlertController {
        return UIAlertController(title: "", message: "", preferredStyle: .alert)
    }
}

extension UIViewController: UtilityCompatible {}

class CustomAlertController: UIAlertController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
