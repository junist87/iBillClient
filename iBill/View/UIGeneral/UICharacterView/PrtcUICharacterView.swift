//
//  PrtcCharacterUIView.swift
//  iBill
//
//  Created by CiaoLee on 2018. 2. 10..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation

protocol PrtcUICharacterView {
    func showBudget(budget: Int64, spend: Int64)
    func showPeriod(period: Int, spend: Int)
    func showMessage(message: String)
}
