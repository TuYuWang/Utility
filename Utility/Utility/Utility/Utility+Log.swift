//
//  Utility+Log.swift
//  Utility
//
//  Created by 涂育旺 on 2018/1/29.
//  Copyright © 2018年 MYXG. All rights reserved.
//


func print(condition: Bool, message: @autoclosure() -> String, file: String = #file, line function: String = #function, line: Int = #line) {
    if condition { return }
    print("------------------------\nFaild: \(message()) \nflie: \(file) \nfunction: \(function) \nline: \(line)\n------------------------")
}

