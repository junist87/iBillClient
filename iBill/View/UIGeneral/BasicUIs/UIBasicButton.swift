//
//  BasicUIButton.swift
//  iBill
//
//  Created by CiaoLee on 2018. 2. 9..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class UIBasicButton: UIButton {
    let btLabelText: String
    let bdrColor: UIColor
    let lblColor: UIColor
    
    init(label: String, borderColor: UIColor, labelColor: UIColor) {
        bdrColor = borderColor
        lblColor = labelColor
        btLabelText = label
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.setDefault()
    }
    
    // 인터페이스 빌더로 못만들게 하기
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDefault() {
        self.setTitleColor(self.lblColor, for: UIControlState.normal)
        self.layer.cornerRadius = 5
        self.layer.borderColor = self.bdrColor.cgColor
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        self.setTitle(btLabelText, for: .normal)
    }
    
}
