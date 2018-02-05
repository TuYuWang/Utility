//
//  AlertView.swift
//  Utility
//
//  Created by 涂育旺 on 2018/2/5.
//  Copyright © 2018年 MYXG. All rights reserved.
//

import UIKit

class AlertView: UIView {

    @IBOutlet weak var success: UIButton!
    @IBOutlet weak var cancel: UIButton!

}

extension AlertView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        success.addTarget(self, action: #selector(successClick(callback:)), for: .touchUpInside)
        cancel.addTarget(self, action: #selector(cancelClick(callback:)), for: .touchUpInside)
    }
}

extension AlertView: AlertActionCompatible {
    
    @objc public func successClick(callback: AlertActionCallback) {
        callback!("nil")
    }
    
    @objc public func cancelClick(callback: AlertActionCallback) {
        callback!("nil")
    }
}

extension AlertView: XibCompatible {}

