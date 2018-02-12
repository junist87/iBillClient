//
//  SHA256Test.swift
//  iBillTests
//
//  Created by CiaoLee on 2018. 2. 7..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import XCTest
@testable import iBill

class SHA256Test: XCTestCase {
    
    var sha256: SHA256!
    
    override func setUp() {
        super.setUp()
        sha256 = SHA256()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sha256 = nil
    }
    
   
    func testSHA256() {
        var value = "ABCDE";
        
        let encrpytValue = "f0393febe8baaa55e32f7be2a7cc180bf34e52137d99e056c817a9c07b8f239a" //자바 모듈에서 복사해옴
        value = sha256.encrpyt(value: value)
        NSLog("encryptValue = \(value)")
        XCTAssertEqual(encrpytValue, value)
    }
    
}
