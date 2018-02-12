//
//  GagueBar.swift
//  iBill
//
//  Created by CiaoLee on 2018. 2. 10..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class UIGaugeBar: UIView {
    private let lbStatus = UILabel()
    private let gaugeBar = UIView()
    private var maxGauge: Int64 = 100
    private var gauge: Int64 = 100

    public var bgColor: UIColor? {
        didSet(color) {
            self.backgroundColor = color
        }
    }

    public var barColor: UIColor {
        didSet(color) {
            gaugeBar.backgroundColor = color
        }
    }

    public var borderColor: UIColor {
        didSet (color) {
            self.layer.borderColor = color.cgColor
        }
    }
    override var frame: CGRect {
        didSet(frame) {
//            NSLog("frame 변화 : \(frame)")
            self.allocateUIs()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        // 기본값 지정
        bgColor = UIColor.red
        barColor = UIColor.green
        borderColor = UIColor.gray

        super.init(frame: CGRect(x: 0, y: 0, width: 150, height: 30))

        self.allocateUIs()  // UI 위치 지정하기
        self.addUIs()       // UIs 등록하기
    }


    private func addUIs() {
        // UI 입력하기
//        NSLog("UIs 등록됨")
        self.addSubview(gaugeBar)
        self.addSubview(lbStatus)
    }

    private func allocateUIs() {
        // 기본 설정
        self.backgroundColor = bgColor
        self.layer.cornerRadius = 5
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
        self.layer.borderWidth = 2

        gaugeBar.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        gaugeBar.backgroundColor = barColor

//        NSLog("gaugeBar Frame = \(gaugeBar.frame)")

        lbStatus.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        lbStatus.textAlignment = .center
        lbStatus.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        animateValue()
    }

    func setValue(gauge gag: Int64, maxGauge max: Int64) {
        self.maxGauge = max
        self.gauge = gag

        // 뷰 표시하기
        self.animateValue()
    }

    // 현재 저장된 값으로 뷰 바꾸기
    private func animateValue() {
        // maxGauge = 0 이면 무한대가 되므로 비율을 정해준다.
        var rate: CGFloat = 0
        if maxGauge != 0 {

            rate = (CGFloat(maxGauge - gauge) / CGFloat(maxGauge))    // 에너지바 비율
//            NSLog("rate = \(rate)")
        }

        lbStatus.text = "\(gauge)/ \(maxGauge)"  // 텍스트
        // 애니메이션 효과로 크기 바꾸기
        UIView.animate(withDuration: 0.3) {
            self.gaugeBar.frame = CGRect(x: self.gaugeBar.frame.minX, y: self.gaugeBar.frame.minY, width: self.frame.width * rate, height: self.frame.height)    // 비율사이즈로 조정
        }
    }

}
