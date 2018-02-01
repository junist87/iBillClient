//
//  Context.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 23..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation

public class Context {
    static public let iBill = Context()
    
    /* ------------------------------ */
    // StandAlone Modules
    private let accountMao = AccountMao()
    private let iconsMao = IconsMao()
    private let spTypeMao = SPTypeMao()
    private let budgetMao = BudgetMao()
    private let spMoneyMao = SPMoneyMao()
    
    // Account Model
    public lazy var acModel: AccountModel = {
        return ACModelImpl(acServer: acServer, acMao: accountMao)
    }()
    private let acServer = ACServerImpl()
    
    
    // Account ViewModel

    
    
    private init() {
    }
    
}
