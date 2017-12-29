//
//  Utility.swift
//  Utility
//
//  Created by Mac on 2017/12/28.
//  Copyright © 2017年 MYXG. All rights reserved.
//

public struct Utility<Base>{
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol UtilityCompatible {
    associatedtype CompatibleType
    var ul: CompatibleType { get }
}

extension UtilityCompatible {
    public var ul: Utility<Self> { get { return Utility(self) } }
}

extension String: UtilityCompatible {}

extension Array {
    
    @discardableResult
    func accumulate<Result>(_ initialResult: Result, _ nextPartialResult:(Result, Element) -> Result) -> [Result] {
        var running = initialResult
        return map { next in
            running = nextPartialResult(running, next)
            return running
        }
    }
    
}

extension Sequence {
    
    @discardableResult
    func all(matching predicate: (Iterator.Element) -> Bool) -> Bool {
        return !contains { !predicate($0) }
    }
}
