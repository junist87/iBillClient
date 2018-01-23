//
//  AccountMaoTest.swift
//  iBillTests
//
//  Created by CiaoLee on 2018. 1. 23..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import XCTest
@testable import iBill


class AccountMaoTest: XCTestCase {
    var accountMao: AccountMao!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        accountMao = AccountMao()
        accountMao.deleteAllAccountMO()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        accountMao = nil
    }
    
    func testSetAccountInfo() {
        let sampler = Sampler()
        let testSize = 100
        
        // 데이터베이스에 아무것도 없을 때에는 정보를 불러올수 없다.
        guard let _ = accountMao.getRecentlyAccount() else {
            for _ in 1 ... testSize {
                let email = sampler.getRandomEmail()
                let passwd = sampler.getRandomPasswd()
                
                _ = accountMao.setAccount(email: email, passwd: passwd)
                let getAccount = accountMao.getRecentlyAccount()
                
                NSLog("uuid \(String(describing: getAccount?.uuid))" )
                XCTAssertEqual(getAccount?.email, email, "이메일이 틀립니다.")
                XCTAssertEqual(getAccount?.passwd, passwd, "비밀번호가 틀립니다.")
            }
            return
        }
        
        // 데이터가 불러져 왔다면 어카운트 데이터베이스 전체삭제 실패한 것
        XCTFail()
        
        
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
