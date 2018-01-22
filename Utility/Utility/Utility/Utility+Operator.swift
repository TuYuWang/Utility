
//
//  Utility+Operator.swift
//  Utility
//
//  Created by 涂育旺 on 2018/1/22.
//  Copyright © 2018年 MYXG. All rights reserved.
//

///程序挂起的三种方式
///- fatalError: 无条件停止操作
///- assert:     检查条件，当条件结果为false时，停止执行并输出信息，在发布版本中，assert会被移除掉，操作不挂起
///- precondition: 跟assert类似，只是在发布版本中不会被移除，条件为false时，程序挂起


infix operator !!

///解包错误提示
func !!<T>(wrapped: T?, failureText: @autoclosure() -> String) -> T {
    
    if let x = wrapped {
        return x
    }
    fatalError(failureText)
}

infix operator !?

///调试时错误直接崩溃，发布环境为0
func !?<T: ExpressibleByIntegerLiteral>(wrapped: T?, failureText: @autoclosure() -> String) -> T {
    assert(wrapped != nil, failureText)
    return wrapped ?? 0
}

func !?<T: ExpressibleByArrayLiteral>(wrapped: T?, failureText: @autoclosure() -> String) -> T {
    assert(wrapped != nil, failureText)
    return wrapped ?? []
}

func !?<T: ExpressibleByStringLiteral>(wrapped: T?, failureText: @autoclosure() -> String) -> T {
    assert(wrapped != nil, failureText)
    return wrapped ?? ""
}

///提供发布版本自定义默认值
func !?<T>(wrapped: T?, nilDefault: @autoclosure() -> (value: T, text: String)) -> T {
    assert(wrapped != nil, nilDefault().text)
    return wrapped ?? nilDefault().value
}

///对于返回Void的函数，检测可选链调用碰到nil，且并没有进行完操作的情况
func !?(wrapped:()?, failureText: @autoclosure() -> String) {
    assert(wrapped != nil, failureText)
}
