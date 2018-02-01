//
//  LoginViewModel
//  iBill
//
//  Created by CiaoLee on 2018. 1. 28..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation

protocol LoginViewModel {
    func autoLogin()
    func login(email: String, passwd: String)
    func showForgetView()
    func showJoinView()
    func showConfirmView()
    func launchIBill()
}
