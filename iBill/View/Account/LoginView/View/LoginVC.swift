//
//  AccountVC.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 26..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UIPauseView, PrtcLoginView{
    // 뷰모델 객체
    lazy var viewModel: LoginViewModel = {
        return LoginViewModelImpl(accountView: self)
    }()
    
    // UIs
    let txEmail = UIEmailTextField()
    let txPasswd = UIPasswdTextField()
    let btLogin = UIBasicButton(label: "Login", borderColor: UIColor.orange, labelColor: UIColor.orange)
    let btJoin = UIBasicButton(label: "Join", borderColor: UIColor.blue, labelColor: UIColor.blue)
    
    
    
    public init() {
        super.init(nibName: nil, bundle: nil)   // 코드로만 화면 구성하기
        self.view.backgroundColor = UIColor.white
        self.allocateUIs()
    }
    
    // 인터페이스 빌더로 만들지 못하게 하기
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 셋팅하기
    func allocateUIs() {
        // 위치 지정하기
        let uiWidth = UIScreen.main.bounds.width
        let uiHeight = UIScreen.main.bounds.height
        let txFieldWidth: CGFloat = 200.0
        let txFieldHeight: CGFloat = 25
        let margin: CGFloat = 10
        let firstTxFieldMinX = (uiWidth - txFieldWidth) / 2
        let firstTxFieldMinY = ((uiHeight - ( txFieldHeight * 3 + margin * 2 )) / 2)
        
        // 위에서부터 차례대로 연결하여 배치
        txEmail.frame = CGRect(x: firstTxFieldMinX , y: firstTxFieldMinY, width: txFieldWidth, height: txFieldHeight)
        txPasswd.frame = CGRect(x: txEmail.frame.minX, y: txEmail.frame.maxY + margin, width: txFieldWidth, height: txFieldHeight)
        btLogin.frame = CGRect(x: txPasswd.frame.minX, y: txPasswd.frame.maxY + margin, width: txFieldWidth, height: txFieldHeight)
        btJoin.frame = CGRect(x: btLogin.frame.minX, y: btLogin.frame.maxY + margin, width: txFieldWidth, height: txFieldHeight)
        
        // 제스쳐 등록하기
        self.btLogin.addTarget(self, action: #selector(btLoginAction(_:)), for: .touchUpInside)
        self.btJoin.addTarget(self, action: #selector(btJoinAction(_:)), for: .touchUpInside)
        
        
        // 기본값
        txEmail.placeholder = "Email"
        txPasswd.placeholder = "Password"
        
        // 객체 등록
        self.view.addSubview(txEmail)
        self.view.addSubview(txPasswd)
        self.view.addSubview(btLogin)
        
    }
    
    @objc func btJoinAction(_ sender: Any?) {
        viewModel.touchJoinBt()
    }
    
    @objc func btLoginAction(_ sender: Any?) {
        guard let email = txEmail.text, let passwd = txPasswd.text else {
            return
        }
        viewModel.login(email: email, passwd: passwd)
    }

    func showMessage(_ message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    func showJoinView() {
        let joinVC = JoinVC()
        joinVC.modalTransitionStyle = .crossDissolve
        self.present(joinVC, animated: true) {
            // 창 비우기
            self.resetTxField()
        }
    }
    
    func showForgetView() {
        let forget = ForgetVC()
        forget.modalTransitionStyle = .crossDissolve
        self.present(forget, animated: true) {
            self.resetTxField()
        }
    }
    
    func showConfirmView() {
        let confirm = ConfirmVC()
        confirm.modalTransitionStyle = .crossDissolve
        self.present(confirm, animated: true) {
            self.resetTxField()
        }
    }
    
    func launchIBill() {
        let ibill = IBillMainVC()
        ibill.modalTransitionStyle = .partialCurl
        self.present(ibill, animated: true) {
            
        }
    }
    
    func resetTxField() {
        self.txEmail.text = ""
        self.txPasswd.text = ""
    }
    


}
