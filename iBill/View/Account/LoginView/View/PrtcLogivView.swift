//
//  AccountViewProtocol.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 26..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation

public protocol PrtcLoginView {
    func showMessage(_ msg: String)
    func pause(message: String)
    func unPause()
    func launchIBill()
    func showJoinView()
    func showForgetView()
    func showConfirmView()
}
