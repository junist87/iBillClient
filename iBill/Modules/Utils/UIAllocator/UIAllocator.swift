//
//  UIAllocator.swift
//  iBill
//
//  Created by CiaoLee on 2018. 2. 11..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import CoreGraphics

struct UIAllocator {
    let baseLocation: CGFloat
    let uiSize: CGFloat
    let margin: CGFloat
    let cells: Int
    
    func getCoordinate(_ targetCell: Int) -> CGFloat {
        // 데이터 형변환
        let wCell = CGFloat(cells)
        let tCell = CGFloat(targetCell)
        
        let unitHeight = (uiSize - (margin * (wCell - 1))) / wCell
        
        return ((tCell - 1) * (margin + unitHeight)) + baseLocation
    }
}
