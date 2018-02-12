//
//  Utility+Alert.swift
//  Utility
//
//  Created by 涂育旺 on 2018/2/4.
//  Copyright © 2018年 MYXG. All rights reserved.
//

import UIKit

// MARK: System

typealias attribute = [NSAttributedStringKey: Any]

fileprivate enum attributeKey: String {
    
    case attributedTitle
    case attributedMessage
    case titleTextColor
    
}
extension UIAlertController {
    
    @discardableResult
    func title(_ type: attribute) -> UIAlertController {
        guard let title = self.title else { return self }
        let attributeTitle = NSAttributedString(string: title, attributes: type)
        self.setValue(attributeTitle, forKey: attributeKey.attributedTitle.rawValue)
        return self
    }
    
    @discardableResult
    func message(_ type: attribute) -> UIAlertController {
        guard let message = self.message else { return self }
        let attributeMessage = NSAttributedString(string: message, attributes: type)
        self.setValue(attributeMessage, forKey: attributeKey.attributedMessage.rawValue)
        return self
    }
    
    @discardableResult
    func cancel(_ type: UIColor) -> UIAlertController {
        let actions = self.actions.filter { $0.style == .cancel }
        guard let action = actions.first else { return self }
        action.setValue(type, forKey: attributeKey.titleTextColor.rawValue)
        return self
    }
    
    @discardableResult
    func sure(_ type: UIColor) -> UIAlertController {
        let actions = self.actions.filter { $0.style == .default }
        _ = actions.map { $0.setValue(type, forKey: attributeKey.titleTextColor.rawValue) }
        return self
    }
}
