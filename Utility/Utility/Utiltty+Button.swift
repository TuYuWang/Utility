//
//  Utiltty+Button.swift
//  Utility
//
//  Created by 涂育旺 on 2018/2/9.
//  Copyright © 2018年 MYXG. All rights reserved.
//

import UIKit

typealias voidCallback = (() -> Void)
let title = "获取验证码"
let time  = 60

extension Utility where Base: UIView {
    
    func add(verifyCode frame: CGRect, block: @escaping voidCallback) {
        
        let verifyBtn = Init(UIButton(type: .custom)) {
            $0.frame = frame
            $0.setTitle(title, for: .normal)
            $0.addTarget(base, action: #selector(base.getVerifyCode(button:)), for: .touchUpInside)
            $0.callback = block
        }
        base.addSubview(verifyBtn)
    }
}

// MARK: Selector

extension UIView {
    
    @objc fileprivate func getVerifyCode(button: UIButton) {
        
        button.callback()
        
        var timeout = time
        let queue = DispatchQueue.global()
        let timer = DispatchSource.makeTimerSource(flags: .strict, queue: queue)
        timer.schedule(wallDeadline: DispatchWallTime.now(), repeating: DispatchTimeInterval.seconds(1), leeway: DispatchTimeInterval.microseconds(0))
    
        timer.setEventHandler {
            
            if timeout <= 0 {
                timer.cancel()
                DispatchQueue.main.async {
                    button.setTitle(title, for: .normal)
                    button.isEnabled = true
                    button.alpha = 1
                }
            } else {
                let seconds = timeout % (timeout * 2)
                let result = String(describing: seconds)
                DispatchQueue.main.async {
                    button.setTitle("\(result)秒", for: .normal)
                    button.isEnabled = false
                    button.alpha = 0.5
                    print(result)
                }
                
                timeout = timeout - 1
            }
        }
        timer.resume()
    }
}


// MARK: UIButton

private var callbackKey: Void?

extension UIButton {
    
    var callback: voidCallback {
        
        set {
            objc_setAssociatedObject(self, &callbackKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
        
        get {
            return objc_getAssociatedObject(self, &callbackKey) as! voidCallback
        }
    }
    
}
