//
//  RegulaExpressUtil.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 26..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation

protocol RegulaExpressUtil {
    func checkEmail(email: String) -> Bool
    func checkPasswd(passwd: String) -> Bool
    func checkNickname(nickname: String) -> Bool
}
