//
//  UIPauseView.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 29..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit


protocol UIPauseView {
    func pause(uiView: UIView)
    func pause(message: String)
    func pauseWithIndicator(message: String)
    func unPause()
}


extension UIPauseView {

    private func pauseCustomView(customView: UIView, superView: UIView) {
        // 컨테이너 뷰가 존재하는지 검사 -> 존재하지 않을때 등록한다
        guard let _ = superView.viewWithTag(getTag()) else {
            // 태그로 지정된 뷰가 없을때 -> 뷰를 등록한다
            let containerView = getContainerView(uiFrame: superView.frame)
            containerView.addSubview(getBlurView(uiFrame: superView.frame))
            containerView.addSubview(customView)
            
            // 컨테이너 뷰를 등록한다
            showView(uiView: containerView, superView: superView)
            return
        }
    }
    
    private func unPause(superView: UIView) {
        // 컨테이너 뷰가 존재하는지 검사
        if let containerView = superView.viewWithTag(getTag())  {
            hideView(uiView: containerView)
        }
    }
    
    // 뷰를 화면에 등록한다
    private func showView(uiView: UIView, superView: UIView) {
        // 창을 투명하게 만든후 서서히 나타나게 하는 효과
        uiView.alpha = 0
        superView.addSubview(uiView)
        
        UIView.animate(withDuration: 0.3) {
            uiView.alpha = 1
        }
    }
    
    // 뷰를 화면에서 삭제한다
    private func hideView(uiView: UIView) {
        // 화면을 사라지게 한다
        UIView.animate(withDuration: 0.3) {
            uiView.alpha = 0
        }
        
        // 애니메이션이 끝나면 뷰에서 삭제한다
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            uiView.removeFromSuperview()
        }
    }
    
    // 태그를 기준으로 뷰를 찾는다.
    // 태그를 관리하는 모듈을 만들면 이곳을 수정한다
    private func getTag() -> Int {
        return 40201321421
    }
    
    // 컨테이너 뷰를 생성한다
    private func getContainerView(uiFrame: CGRect) -> UIView {
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: uiFrame.width, height: uiFrame.height)
        containerView.tag = getTag()
        return containerView
    }
    
    // 배경 블러 뷰를 생성한다
    private func getBlurView(uiFrame: CGRect) -> UIView {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRect(x: 0, y: 0, width: uiFrame.width, height: uiFrame.height)
        blurEffectView.alpha = 0.5
        return blurEffectView
    }
    
    // 인디케이터뷰를 생성한다
    private func getIndicatorView(message: String, superViewFrame: CGRect) -> UIView {
        let containerView = UIView()
        let screenBounds = superViewFrame
        containerView.frame = CGRect(x: 0, y: (screenBounds.height/2) - 35, width: screenBounds.width, height: 70)
        
        // 인디케이터
        let indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: (containerView.frame.width/2) - 20, y: 0, width: 40, height: 40)
        indicator.startAnimating()
        containerView.addSubview(indicator)
        
        
        // 라벨
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 40, width: containerView.frame.width, height: 30)
        label.textColor = UIColor.white
        label.text = message
        label.textAlignment = .center
        containerView.addSubview(label)
        
        return containerView
    }
    
    private func getMessageView(message: String, superViewFrame: CGRect) -> UIView {
        let containverView = UIView()
        containverView.frame = CGRect(x: 0, y: 0, width: superViewFrame.width, height: superViewFrame.height)
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: superViewFrame.width, height: superViewFrame.height)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = message

        
        containverView.addSubview(label)
        return containverView
    }
}

extension UIPauseView where Self: UIView {
    func getSuperView() -> UIView? {
        return self
    }
    
    func pause(uiView: UIView) {
        guard let superView = getSuperView() else {
            return
        }
        pauseCustomView(customView: uiView, superView: superView)
    }
    
    func pause(message: String) {
        guard let superView = getSuperView() else {
            return
        }
        let messageView = getMessageView(message: message, superViewFrame: superView.frame)
        pauseCustomView(customView: messageView, superView: superView)
    }
    
    func pauseWithIndicator(message: String) {
        guard let superView = getSuperView() else {
            return
        }
        let indicatorView = getIndicatorView(message: message, superViewFrame: superView.frame)
        pauseCustomView(customView: indicatorView, superView: superView)
    }
    
    func unPause() {
        guard let superView = getSuperView() else {
            return
        }
        unPause(superView: superView)
    }
}

extension UIPauseView where Self: UIViewController {
    func getSuperView() -> UIView? {
        return self.view.superview
    }
    
    func pause(uiView: UIView) {
        guard let superView = getSuperView() else {
            return
        }
        pauseCustomView(customView: uiView, superView: superView)
    }
    
    func pause(message: String) {
        guard let superView = getSuperView() else {
            return
        }
        let messageView = getMessageView(message: message, superViewFrame: superView.frame)
        pauseCustomView(customView: messageView, superView: superView)
    }
    
    func pauseWithIndicator(message: String) {
        guard let superView = getSuperView() else {
            return
        }
        let indicatorView = getIndicatorView(message: message, superViewFrame: superView.frame)
        pauseCustomView(customView: indicatorView, superView: superView)
    }
    
    
    func unPause() {
        guard let superView = getSuperView() else {
            return
        }
        unPause(superView: superView)
    }
}
