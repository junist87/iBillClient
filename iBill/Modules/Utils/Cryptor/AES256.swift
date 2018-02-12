//
//  AES256.swift
//  iBill
//
//  Created by CiaoLee on 2018. 2. 7..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import CryptoSwift

public struct AESUnit {
    
}

public class AES256 {
    public func makeKey() {
        
    }
    
    private func makeIv(value: String) -> String{
        return "A"
    }
    
    public func encrpyt(key: String, iv: String, value: String) -> String!  {
        do {
            let encrpytor = try AES (key: key, iv: iv)
            let encryptValue = try encrpytor.encrypt(value.bytes)
            return encryptValue.toHexString()
        } catch {
            return nil
        }
        
    }
    
    public func decrypt(value : String) -> String {
        return "A"
    }
}
