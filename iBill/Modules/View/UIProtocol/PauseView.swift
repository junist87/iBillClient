//
//  PauseView.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 29..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit


protocol PauseView {
    func pause(uiView: UIView)
    func pause(message: String)
    func unPause()
}

extension PauseView where Self: UIViewController {
    
    func pause(uiView: UIView) {
        
        // 최고 상위의 뷰 찾기
        guard let superView = self.view.superview else { return }
        // 컨테이너 뷰가 존재하는지 검사 -> 존재하지 않을때 등록한다
        guard let _ = superView.viewWithTag(getTag()) else {
            // 태그로 지정된 뷰가 없을때 -> 뷰를 등록한다
            let containerView = getContainerView()
            containerView.addSubview(getBlurView())
            containerView.addSubview(uiView)
            
            // 컨테이너 뷰를 등록한다
            showView(uiView: containerView)
            return
        }
    }
    
    func pause(message: String) {
        // 최고 상위의 뷰 찾기
        guard let superView = self.view.superview else { return }
        // 컨테이너 뷰가 존재하는지 검사  -> 존재하지 않을때 등록한다
        guard let _ = superView.viewWithTag(getTag()) else {
            // 태그로 지정된 뷰가 없을때 -> 뷰를 등록한다
            let containerView = getContainerView()
            containerView.addSubview(getBlurView())
            containerView.addSubview(getIndicatorView(message: message))
            
            // 컨테이너 뷰를 등록한다
            showView(uiView: containerView)
            return
        }
    }
    
    func unPause() {
        // 최고 상위의 뷰 찾기
        guard let superView = self.view.superview else { return }
        // 컨테이너 뷰가 존재하는지 검사
        if let containerView = superView.viewWithTag(getTag())  {
           hideView(uiView: containerView)
        }
    }
    
    
    // 뷰를 화면에 보여준다
    private func showView(uiView: UIView) {
        // 창을 투명하게 만든후 서서히 나타나게 하는 효과
        uiView.alpha = 0
        self.view.addSubview(uiView)
        
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
    private func getContainerView() -> UIView {
        let containerView = UIView()
        containerView.frame = UIScreen.main.bounds
        containerView.tag = getTag()
        return containerView
    }
    
    // 배경 블러 뷰를 생성한다
    private func getBlurView() -> UIView {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIScreen.main.bounds
        blurEffectView.alpha = 0.5
        return blurEffectView
    }
    
    // 인디케이터뷰를 생성한다
    private func getIndicatorView(message: String) -> UIView {
        let containerView = UIView()
        let screenBounds = UIScreen.main.bounds
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
}
