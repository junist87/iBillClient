//
//  LoginViewModelImpl
//  iBill
//
//  Created by CiaoLee on 2018. 1. 26..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation

public class LoginViewModelImpl: LoginViewModel{
    
    
   
    let loginView: PrtcLoginView
    let accountModel: AccountModel
    
    init(accountView view: PrtcLoginView) {
        accountModel = Context.iBill.acModel
        loginView = view
    }
    
    func autoLogin() {
        // 동기통신이므로 화면을 정지 시킨다
        loginView.pause(message: "로그인 중입니다.")
        let login = accountModel.autoLogin()
        
        // 화면을 다시 플레이
        loginView.unPause()
        
        // 로그인 결과
        self.loginAction(login: login)
    }
    
    func login(email: String, passwd: String) {
        // 동기통신이므로 화면을 정지 시킨다
        loginView.pause(message: "로그인 중입니다.")
        let login = accountModel.login(email: email, passwd: passwd)
        
        // 화면을 다시 플레이 
        loginView.unPause()
        
        // 로그인 결과
        self.loginAction(login: login)
    }
    
    private func loginAction(login: ACLogin) {
        switch login {
        // 로그인 성공
        case .OK:
            self.loginOk()
        // 알수 없는 실패
        case .UnknowFail:
            loginView.showMessage("서버에러\n다시 한번 시도해 주십시오.")
        default:
            loginView.showMessage("이메일, 비밀번호를 확인하여 주십시오.")
        }
    }
    
    func touchForgetBt() {
        loginView.showForgetView()
    }
    
    func touchJoinBt() {
        loginView.showJoinView()
    }
    
    func launchIBill() {
        loginView.launchIBill()
    }
    
    
    private func loginOk() {
        // 여기에 로그인 확인되면 실행할 코드 입력하기
        loginView.launchIBill()
    }
    

}
