//
//  AnimationHandler.swift
//  iBill
//
//  Created by CiaoLee on 2018. 2. 12..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

struct UIViewAnimationHandler {
    var animateTimeInterval: Double  = 0.3
    
    
    /**
    아래에서 위로 올라오는 애니메이션
     - parameter view: 움직임의 대상이 되는 뷰
     - parameter superViewFrame: 뷰의 이동이 기준이 되는 수퍼뷰
     
     */
    func animateBottomToView(view: UIView, superViewFrame: CGRect) {
        let axisMinX: CGFloat = (superViewFrame.width - view.frame.width) / 2   // 중앙정렬
        let axisMinY: CGFloat = (superViewFrame.height - view.frame.height)     // 아래기준
        
        // 최초 뷰는 슈퍼뷰 밖의 아래에 존재
        view.frame = CGRect(x: axisMinX, y: superViewFrame.height, width: view.frame.width, height: view.frame.height)
        
        UIView.animate(withDuration: TimeInterval(animateTimeInterval)) {
            view.frame = CGRect(x: axisMinX, y: axisMinY, width: view.frame.width, height: view.frame.height)
        }
    }
    
    /**
    슈퍼뷰 아래로 내려가는 애니메이션
     - parameter view: 움직임의 대상이 되는 뷰
     - parameter superViewFrame: 뷰의 이동이 기준이 되는 수퍼뷰
     */
    func animateDownside(view: UIView, superViewFrame: CGRect) {
        UIView.animate(withDuration: TimeInterval(animateTimeInterval)) {
            view.frame = CGRect(x: view.frame.minX, y: superViewFrame.height, width: view.frame.width, height: view.frame.height)
        }
    }

    
    /**
    서서히 나타나는 애니메이션 효과
     - parameter view: 애니메이션 대상이 되는 뷰
     */
    func animateShow(view: UIView) {
        view.alpha = 0
        UIView.animate(withDuration: TimeInterval(animateTimeInterval)) {
            view.alpha = 1
        }
    }
    
    /**
    뷰를 가운데 등록하고 서서히 나타나는 애니메이션 효과
     - parameter view: 애니메이션 대상이 되는 뷰
     -
     */
    func animateShowCenter(view: UIView, superViewFrame: CGRect) {
        // 뷰를 중앙에 위치 시키기
        let axisMinX: CGFloat = (superViewFrame.width - view.frame.width) / 2
        let axisMinY: CGFloat = (superViewFrame.height - view.frame.height) / 2
        view.frame = CGRect(x: axisMinX, y: axisMinY, width: view.frame.width, height: view.frame.height)
        
        self.animateShow(view: view)
    }
    
    /**
    서서히 사라지는 애니메이션 효과
     - parameter view: 애니메이션 대상이 되는 뷰
     */
    func animateHide(view: UIView) {
        UIView.animate(withDuration: TimeInterval(animateTimeInterval)) {
            view.alpha = 0
        }
    }
}
