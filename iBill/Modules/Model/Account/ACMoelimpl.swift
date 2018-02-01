//
//  ACServiceImpl.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 26..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation

public class ACModelImpl: AccountModel {
    private let acServer: ACServer
    private let acMao: AccountMao
    
    init(acServer server: ACServer, acMao mao: AccountMao ) {
        self.acServer = server
        acMao = mao
    }
    
    public func autoLogin() -> ACLogin {
        // 최근 아이디 비밀번호 가저오기
        guard let user = acMao.readRecently() else {
            return .NoUserData
        }
        
        // 로그인하기
        return login(email: user.email, passwd: user.passwd)
    }
    
    public func login(email: String, passwd: String) -> ACLogin {
        return acServer.login(email: email, passwd: passwd)
    }
    
    public func join(email: String, passwd: String, nickname: String) -> ACJoin {
        return acServer.join(email: email, passwd: passwd, nickname: nickname)
    }
    
    public func forget(email: String) -> ACForget {
        return acServer.forget(email: email)
    }
    
    public func isDuplicated(email: String, baAction: BAAction, vwAction: VWAction) {
        return acServer.isDuplicated(email: email, baAction: baAction, vwAction: vwAction)
    }
    
    
    
    
    
}
