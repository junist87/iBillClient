//
//  TextReader.swift
//  iBillTests
//
//  Created by CiaoLee on 2018. 1. 23..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import XCTest
@testable import iBill

class TextReaderTest: XCTestCase {
    
    var textReader: TextReader!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        textReader = TextReader()
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        textReader = nil
    }
    
    func testMakeIconList() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
        let getString = textReader.getText(filename: "iconList")
        NSLog("출력결과 \n\(getString)")
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
