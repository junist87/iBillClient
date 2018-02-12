//
//  EmailUITextField.swift
//  iBill
//
//  Created by CiaoLee on 2018. 2. 9..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class UIEmailTextField: UITextField, UITextFieldDelegate {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDefault()
    }
    
    // 인터페이스 빌더로 못만들게 하기
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDefault() {
        self.textContentType = UITextContentType.emailAddress
        self.borderStyle = .roundedRect
        //self.delegate = self    // 델리게이트 설정
    }
}
