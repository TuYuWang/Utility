//
//  Utility+Encrypt.swift
//  Utility
//
//  Created by 涂育旺 on 2018/1/2.
//  Copyright © 2018年 MYXG. All rights reserved.
//

import UIKit

extension Utility where Base: Collection {

    public var md5: EncryptResult {
        return encrypt(for: base, with: .md5)
    }
    
    public var sha1: EncryptResult {
        return encrypt(for: base, with: .sha1)
    }
    
    public var sha224: EncryptResult{
        return encrypt(for: base, with: .sha224)
    }
    
    public var sha256: EncryptResult {
        return encrypt(for: base, with: .sha256)
    }
    
    public var sha384: EncryptResult {
        return encrypt(for: base, with: .sha384)
    }
    
    public var sha512: EncryptResult {
        return encrypt(for: base, with: .sha512)
    }
}

fileprivate enum EncryptType {
    
    case md5
    case sha1
    case sha224
    case sha256
    case sha384
    case sha512
    
    public var length: Int {
        
        switch self {
            
        case .md5:
            return Int(CC_MD5_DIGEST_LENGTH)
            
        case .sha1:
            return Int(CC_SHA1_DIGEST_LENGTH)
            
        case .sha224:
            return Int(CC_SHA224_DIGEST_LENGTH)
            
        case .sha256:
            return Int(CC_SHA256_DIGEST_LENGTH)
            
        case .sha384:
            return Int(CC_SHA384_DIGEST_LENGTH)
            
        case .sha512:
            return Int(CC_SHA512_DIGEST_LENGTH)
        }
    }
    
}

public struct EncryptResult {
    public var str: String?
    public var data: Data?
    public static var `default`: EncryptResult {
        return EncryptResult(nil, data: nil)
    }
    
    public init(_ str: String?, data: Data?) {
        self.str = str
        self.data = data
    }
}

extension Utility {
    
    fileprivate func encrypt(for str: Base, with type: EncryptType) -> EncryptResult {
        
        let str = String(describing: str)
        
        guard let cStr = str.cString(using: .utf8) else { return EncryptResult.default }
        
        let buffer = encrypt(for: cStr, with: type)

        let md5String = NSMutableString();
        for i in 0 ..< type.length {
            md5String.appendFormat("%02x", buffer[i])
        }
        
        let data = Data(bytes: buffer, count: type.length)
        
        free(buffer)
        
        let result = EncryptResult(String(md5String), data: data)
        
        return result
    }
    
    fileprivate func encrypt(for data: [CChar], with type: EncryptType) -> UnsafeMutablePointer<UInt8> {
        
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: type.length)
        
        switch type {
            
        case .md5:
            CC_MD5(data, (CC_LONG)(strlen(data)), buffer)
            
        case .sha1:
            CC_SHA1(data, (CC_LONG)(strlen(data)), buffer)
            
        case .sha224:
            CC_SHA224(data, (CC_LONG)(strlen(data)), buffer)
            
        case .sha256:
            CC_SHA256(data, (CC_LONG)(strlen(data)), buffer)
            
        case .sha384:
            CC_SHA384(data, (CC_LONG)(strlen(data)), buffer)
            
        case .sha512:
            CC_SHA512(data, (CC_LONG)(strlen(data)), buffer)
        }
        
        return buffer
    }
    
    
}
