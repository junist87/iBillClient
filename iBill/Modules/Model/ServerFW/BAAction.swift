//
//  BAAction.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 26..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation

// 비동기 통신시 백그라운드에서 실행해야할 기능을 담아 이동시켜주는 클래스
public protocol BAAction {
    // 데이터 통신에 성공하면 실행할 메소드
    func success(_ response: Any?)
    
    // 데이터 통신에 실패하면 실행할 메소드
    func fail(_ response: Any?)
}
