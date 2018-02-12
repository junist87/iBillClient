//
//  UIMiniMapInfo.swift
//  iBill
//
//  Created by CiaoLee on 2018. 2. 13..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class UIMiniMapInfo: UIView {
    required init?(coder aDecoder: NSCoder) {
        fatalError("인터페이스 빌더로 만들어질수 없습니다.")
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    }
}
