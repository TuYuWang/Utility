//
//  Utility+Copy.swift
//  Utility
//
//  Created by 涂育旺 on 2018/1/22.
//  Copyright © 2018年 MYXG. All rights reserved.
//

import UIKit

// MARK: 为struct添加copy on write


///在Swift中，isKnownUniquelyReferenced可以检查引用的唯一性
///对于Objective-C的类，它会直接返回false
///创建一个简单的Swift类，将任意的Objective-C对象封装到Swift对象中

final class Box<A> {
    var unbox: A
    init(_ value: A) {
        self.unbox = value
    }
}

struct MyData {
    fileprivate var _data: Box<NSMutableData>
    var _dataForWriting: NSMutableData {
        mutating get {
            if !isKnownUniquelyReferenced(&_data) {
                _data = Box(_data.unbox.mutableCopy() as! NSMutableData)
            }
            return _data.unbox
        }
    }
    
    init(_ data: NSData) {
        self._data = Box(data.mutableCopy() as! NSMutableData)
    }
}

extension MyData {
    mutating func append(_ other: MyData) {
        _dataForWriting.append(other._data.unbox as Data)
    }
}
