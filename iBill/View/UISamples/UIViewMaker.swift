//
//  UIViewMaker.swift
//  iBill
//
//  Created by CiaoLee on 2018. 2. 12..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

struct UIViewMaker {
    func makeBlurView(frame: CGRect) -> UIView {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        blurEffectView.alpha = 0.5
        return blurEffectView
    }
    
    func makeContainerViewWithRoundBorder(borderColor: UIColor) -> UIView{
        let containerView = UIView()
        containerView.layer.cornerRadius = 5
        containerView.layer.borderColor = borderColor.cgColor
        containerView.clipsToBounds = true
        containerView.layer.borderWidth = 2
        return containerView
    }
    
    func makeContainerView(frame: CGRect) -> UIView {
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        return containerView
    }
}
