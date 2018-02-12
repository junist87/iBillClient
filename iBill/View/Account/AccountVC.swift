//
//  AccountVC.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 26..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, LoginView {
    
    lazy var accountVM: AccountViewModel = {
        return AccountVM(accountView: self)
    }()
    
    func showMessage(_ message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    
    func showJoinView() {
        
    }
    
    func showForgetView() {
        
    }
    
    func launchIBill() {
        
    }
    
    func pause(swt: Bool) {
        
    }
    
    
    
}
