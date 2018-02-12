//
//  UIModalView.swift
//  iBill
//
//  Created by CiaoLee on 2018. 2. 12..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

protocol UIModalView {
    func showModalView(view: UIView, modalStyle: UIModalViewStyle)
    func hideModalView()
}

private extension UIView {
    /**
     모달뷰의 제스쳐 등록을 위한 @objc 메소드
     */
    @objc func hideModal() {
        // 객체가 UIModalView 프로토콜-익스텐션을 체택하고 있다면 hideModalView 메소드를 실행시킨다.
        guard let mySelf = self as? UIModalView else { return }
        mySelf.hideModalView()
    }
}

private extension UIViewController {
    /**
     모달뷰의 제스쳐 등록을 위한 @objc 메소드
     */
    @objc func hideModal() {
        // 객체가 UIModalView 프로토콜-익스텐션을 체택하고 있다면 hideModalView 메소드를 실행시킨다.
        guard let mySelf = self as? UIModalView else { return }
        mySelf.hideModalView()
    }
}


extension UIModalView where Self: UIView {
    func showModalView(view: UIView, modalStyle: UIModalViewStyle) {
        self.addModal(targetView: view, modalStyle: modalStyle)
    }
    
    func hideModalView() {
        self.removeModal()
    }
}

extension UIModalView where Self: UIViewController {
    func showModalView(view: UIView, modalStyle: UIModalViewStyle) {
        self.addModal(targetView: view, modalStyle: modalStyle)
    }
    
    func hideModalView() {
        self.removeModal()
    }
}

extension UIModalView {
    
    /**
     수퍼뷰를 가저오는 메소드
     */
    private func getSuperView() -> UIView? {
        if let mySelf = self as? UIView {
            return mySelf
        }
        else if let mySelf = self as? UIViewController {
            return mySelf.view
        }
        else { return nil }
    }
    
    /**
     모달뷰을 화면 등록하는 메소드
     - parameter targetView: 등록할 타깃 뷰
     - parameter modalStyle: 모달뷰가 보여지게 되는 애니메이션 효과
     */
    private func addModal(targetView: UIView, modalStyle: UIModalViewStyle) {
        guard let superView = getSuperView() else { return }    // 수퍼뷰를 가져온다

        
        // 이미 등록되어 있는 모달뷰가 있다면 진행을 취소한다.
        if let _ = superView.viewWithTag(getContainerViewTag()) { return }
        
        // 모달 뷰를 준비한다
        let modalView = makeModalView(customView: targetView, superViewFrame: superView.frame, modalStyle: modalStyle)
        
        // 애니메이션 시작한다
        let animator = UIViewAnimationHandler()
        switch modalStyle {
        case .bottom:
            animator.animateBottomToView(view: modalView.customView, superViewFrame: modalView.containerView.frame)
        case .center:
            animator.animateShowCenter(view: modalView.customView, superViewFrame: modalView.containerView.frame)
        }
        animator.animateShow(view: modalView.bgView)
        
        // 수퍼뷰에 등록한다
        superView.addSubview(modalView.containerView)
        
    }
    
    /**
     모달뷰를 화면에서 삭제하는 메소드
     */
    private func removeModal() {
        // 등록된 모달뷰를 가저온다
        guard let modalView = getContainerView() else { return }
        
        // 애니메이션을 시작한다
        let animator = UIViewAnimationHandler()
        switch modalView.containerView.modalStyle {
        case .bottom:
            animator.animateHide(view: modalView.bgView)
            animator.animateDownside(view: modalView.customView, superViewFrame: modalView.containerView.frame)
        case .center:
            animator.animateHide(view: modalView.containerView)
        }
        
        // 애니메이션이 끝나면 뷰를 제거한다
        let animateTime = Int(animator.animateTimeInterval * 1000)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(animateTime)) {
            modalView.containerView.removeFromSuperview()
        }
    }
    
    /**
     슈퍼 뷰에 등록된 모달뷰를 태그값을 이용하여 추출하는 메소드
     - parameter superView: 모달뷰가 등록되어 있는 슈퍼뷰
     */
    private func getContainerView() -> (containerView: UIModalContainerView, bgView: UIView, customView: UIView)? {
        guard let superView = getSuperView() else { return nil }
        
        guard let containerView = superView.viewWithTag(getContainerViewTag()) as? UIModalContainerView,
            let bgView = superView.viewWithTag(getBgViewTag()),
            let customView = superView.viewWithTag(getCustomViewTag()) else {
                return nil
        }
        return (containerView: containerView, bgView: bgView, customView: customView)
    }
    
    /**
     모달뷰를 만드는 메소드
     - parameter customView: 모달뷰로 보여질 타깃 뷰
     - parameter superViewFrame: 모달뷰가 등록될 있는 슈퍼뷰
     */
    private func makeModalView(customView: UIView, superViewFrame: CGRect, modalStyle: UIModalViewStyle)
        -> (containerView: UIModalContainerView, bgView: UIView, customView: UIView) {
            // 뷰에 태그 준비하기
            customView.tag = getCustomViewTag()                                                     // 태그 입력하기
            let containerView = makeContainerView(frame: superViewFrame, modalStyle: modalStyle)    // 태그 입력된 컨테이너 뷰
            var bgView = makeBlurView(frame: superViewFrame)                                        // 태그 입력된 블러 뷰
            bgView = addGesture(view: bgView)                                                       // 배경에 탭 제스쳐 등록하기
            
            // 컨테이너뷰에 각각의 뷰 등록하기
            containerView.addSubview(bgView)
            containerView.addSubview(bgView)
            containerView.addSubview(customView)
            
            return (containerView: containerView, bgView: bgView, customView: customView)
    }
    
    /**
     배경을 클릭했을때 창을 닫는 제스쳐를 등록하는 메소드
     - parameter view: 제스쳐를 등록할 뷰
     */
    private func addGesture(view: UIView) -> UIView {

        // 제스쳐 감지하기
        view.isUserInteractionEnabled = true
        
        // 제스쳐 감지시 실행할 타깃 액션 정하기
        if let mySelf = self as? UIView {
            view.addGestureRecognizer(UITapGestureRecognizer(target: mySelf, action: #selector(mySelf.hideModal)))
        } else if let mySelf = self as? UIViewController {
            view.addGestureRecognizer(UITapGestureRecognizer(target: mySelf, action: #selector(mySelf.hideModal)))
        }
        
        
        
    
        return view
    }
    
    /**
     배경으로 쓰일 블러(Blur) 뷰를 만드는 메소드. 뷰를 식별한 전용태그가 입력되어 생성된다.
     - parameter frame: 블러(Blur) 뷰의 크기
     */
    private func makeBlurView(frame: CGRect) -> UIView {
        let viewMaker = UIViewMaker()
        let blurView = viewMaker.makeBlurView(frame: frame)
        blurView.tag = getBgViewTag()
        return blurView
    }
    
    /**
     모달뷰로 만들 컨테이너 뷰를 만드는 메소드. 뷰를 식별한 전용태그가 입력되어 생성된다.
     - parameter frame: 뷰의 크기
     */
    private func makeContainerView(frame: CGRect, modalStyle: UIModalViewStyle) -> UIModalContainerView {
        let containerView = UIModalContainerView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), modalStyle: modalStyle)
        containerView.tag = getContainerViewTag()
        return containerView
    }
    
    // 컨테이너 뷰 태그
    private func getContainerViewTag() -> Int {
        return 1392190
    }
    
    // 커스텀 뷰 태그
    private func getCustomViewTag() -> Int {
        return 1392191
    }
    
    // 배경 뷰 태그
    private func getBgViewTag() -> Int {
        return 1392192
    }
}

enum UIModalViewStyle {
    case center
    case bottom
}

class UIModalContainerView: UIView {
    public var modalStyle: UIModalViewStyle
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("인터페이스 빌더로 초기화 불가능")
    }
    
    init(frame: CGRect, modalStyle style: UIModalViewStyle) {
        modalStyle = style
        super.init(frame: frame)
    }
}
