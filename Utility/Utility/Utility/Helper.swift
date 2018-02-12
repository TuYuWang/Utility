//
//  Helper.swift
//  Utility
//
//  Created by 涂育旺 on 2018/2/11.
//  Copyright © 2018年 MYXG. All rights reserved.
//

import Foundation

internal func Init<T>(_ value: T, block: (_ object: T) -> Void) -> T {
    block(value)
    return value
}
