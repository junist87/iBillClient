//
//  AccountVC.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 26..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, PauseView, LoginView{
   
    lazy var loginVM: LoginViewModel = {
        return LoginViewModelImpl(accountView: self)
    }()
    
    @IBOutlet weak var txEmail: UITextField!
    @IBOutlet weak var txPasswd: UITextField!
    
    func showMessage(_ message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    
    func showJoinView() {
        guard let storyboard = self.storyboard else {
            return
        }
        
        let joinVC = storyboard.instantiateViewController(withIdentifier: "JoinVC") as! JoinVC
        joinVC.modalTransitionStyle = .flipHorizontal
        self.present(joinVC, animated: true)
    }
    
    func showForgetView() {
        
    }
    
    func showConfirmView() {
        
    }
    
    func launchIBill() {
        
    }
    
    
    @IBAction func btJoin(_ sender: Any) {
        loginVM.showJoinView()
    }
    
    @IBAction func btForget(_ sender: Any) {
        loginVM.showForgetView()
    }
    
    @IBAction func btLogin(_ sender: Any) {
        let email = txEmail.text!
        let passwd = txPasswd.text!
        
        loginVM.login(email: email, passwd: passwd)
    }
    
    
    
}
