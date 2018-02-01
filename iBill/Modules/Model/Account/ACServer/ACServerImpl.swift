//
//  ACServerImpl.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 27..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation

public class ACServerImpl: ACServer {
    func join(email: String, passwd: String, nickname: String) -> ACJoin {
        return ACJoin.OK
    }
    
    func login(email: String, passwd: String) -> ACLogin {
        return ACLogin.OK
    }
    
    func forget(email: String) -> ACForget {
        return ACForget.OK
    }
    
    func isDuplicated(email: String, baAction: BAAction, vwAction: VWAction) {
        baAction.success(nil)
        vwAction.success(nil)
    }
    
    
}
