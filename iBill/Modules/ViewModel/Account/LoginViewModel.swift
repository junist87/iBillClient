//
//  VMAccount.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 26..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation

public class LoginViewModelImpl: AccountViewModel{
   
    let accountView: LoginView
    let accountModel: AccountModel
    
    init(accountView view: LoginView) {
        accountModel = Context.iBill.acModel
        accountView = view
    }
    
    public func login(email: String, passwd: String) {
        // 동기통신이므로 화면을 정지 시킨다
        accountView.pause(swt: true)
        let login = accountModel.login(email: email, passwd: passwd)
        
        // 화면을 다시 플레이 
        accountView.pause(swt: false)
        switch login {
            // 로그인 성공
            case .OK:
                self.loginOk()
            // 알수 없는 실패
            case .UnknowFail:
                accountView.showMessage("서버에러\n다시 한번 시도해 주십시오.")
            default:
                accountView.showMessage("이메일, 비밀번호를 확인하여 주십시오.")
        }
    }

    
    func showForgetView() {
        accountView.showForgetView()
    }
    
    func showJoinView() {
        accountView.showJoinView()
    }
    
    func launchIBill() {
        accountView.launchIBill()
    }
    
    
    private func loginOk() {
        // 여기에 로그인 확인되면 실행할 코드 입력하기
        accountView.launchIBill()
    }
    

}
