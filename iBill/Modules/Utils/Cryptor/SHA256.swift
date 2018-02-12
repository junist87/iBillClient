//
//  SHA256.swift
//  iBill
//
//  Created by CiaoLee on 2018. 2. 7..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import CryptoSwift

public class SHA256 {
    func encrpyt(value: String) -> String {
        let data = value.bytes
        return data.sha256().toHexString()
    }
}
