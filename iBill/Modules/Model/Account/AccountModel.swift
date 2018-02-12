//
//  AccountService.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 26..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation

public protocol AccountModel {
    // 동기
    func autoLogin() -> ACLogin
    func login(email: String, passwd: String) -> ACLogin
    func join(email: String, passwd: String, nickname: String) -> ACJoin
    func forget(email: String) -> ACForget
    
    // 비동기
    func isDuplicated(email: String, baAction: BAAction, vwAction: VWAction)
}


