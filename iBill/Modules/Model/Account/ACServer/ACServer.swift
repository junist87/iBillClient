//
//  ACSever.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 26..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation

protocol ACServer {
    // 동기통신 메소드
    func login(email: String, passwd: String) -> ACLogin
    func join(email: String, passwd: String, nickname: String) -> ACJoin
    func forget(email: String) -> ACForget
    
    // 비동기통신 메소드
    func isDuplicated(email: String, baAction: BAAction, vwAction: VWAction)
}
