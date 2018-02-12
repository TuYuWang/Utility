//
//  Utility+Xib.swift
//  Utility
//
//  Created by 涂育旺 on 2018/2/5.
//  Copyright © 2018年 MYXG. All rights reserved.
//

import UIKit

protocol XibCompatible {
    var name: String { get }
}

extension XibCompatible  {

    var name: String {
        return String(describing: Self.self)
    }
}


extension Utility where Base: XibCompatible {
    
    var xib: UIView? {
        
        guard case let view as UIView = Bundle.main.loadNibNamed(base.name, owner: nil, options: nil)?.first else {
            return nil
        }
        return view
    }
    
}
