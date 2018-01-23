//
//  IconsMaoTest.swift
//  iBillTests
//
//  Created by CiaoLee on 2018. 1. 24..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import XCTest
@testable import iBill

class IconsMaoTest: XCTestCase {
    
    var iconsMao: IconsMao!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        iconsMao = IconsMao()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        iconsMao = nil
    }
    
    func testImportIcons() {
        iconsMao.importIconList()
        
        if let icon = iconsMao.getIcon(fileId : "A1") {
            NSLog("\(icon.filename) \(String(describing: icon.name)) \(icon.size)")
        }
        
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
