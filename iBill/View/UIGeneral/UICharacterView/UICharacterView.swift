//
//  CharacterUIView.swift
//  iBill
//
//  Created by CiaoLee on 2018. 2. 10..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class UICharacterView: UIView, PrtcUICharacterView {
    private let gaugeBudget = UIGaugeBar()
    private let gaugePeriod = UIGaugeBar()
    private let lbStatus = UILabel()

    private let lbBudget = UILabel()
    private let lbPeriod = UILabel()
    private let lbStatusLabel = UILabel()

    private var isAddUIs = false

    override var frame: CGRect {
        didSet {
            self.allocateUIs()
        }
    }

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 150))  // 기본크기지정
        self.allocateUIs()          // 위치지정하기
        self.addUIs()               // UIs 등록하기
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("인터페이스 빌더로 생성 불가능")
    }

    private func addUIs() {
        self.addSubview(gaugeBudget)
        self.addSubview(gaugePeriod)
        self.addSubview(lbStatus)
        self.addSubview(lbBudget)
        self.addSubview(lbPeriod)
        self.addSubview(lbStatusLabel)
    }

    // UI 배치하기
    private func allocateUIs() {
        let uiHeight = self.frame.height
        let uiWidth = self.frame.width

        let margin: CGFloat = uiHeight * 0.05
        let unitHeight: CGFloat = (uiHeight - (margin * 2)) / 3
        let labelWidth: CGFloat = 40
        let gaugeWidth: CGFloat = uiWidth - labelWidth

        let yAllocator = UIAllocator(baseLocation: 0, uiSize: uiHeight, margin: margin, cells: 3)

        // 예산
        lbBudget.text = "예산"
        lbBudget.frame = CGRect(x: 0, y: yAllocator.getCoordinate(1), width: labelWidth, height: unitHeight)
        gaugeBudget.frame = CGRect(x: labelWidth, y: yAllocator.getCoordinate(1), width: gaugeWidth, height: unitHeight)

        // 기간
        lbPeriod.text = "기간"
        lbPeriod.frame = CGRect(x: 0, y: yAllocator.getCoordinate(2), width: labelWidth, height: unitHeight)
        gaugePeriod.frame = CGRect(x: labelWidth, y: yAllocator.getCoordinate(2), width: gaugeWidth, height: unitHeight)

        // 상태
        lbStatusLabel.text = "상태"
        lbStatusLabel.frame = CGRect(x: 0, y: yAllocator.getCoordinate(3), width: labelWidth, height: unitHeight)
        lbStatus.frame = CGRect(x: labelWidth, y: yAllocator.getCoordinate(3), width: gaugeWidth, height: unitHeight)
        lbStatus.textAlignment = .center
    }

    func showBudget(budget: Int64, spend: Int64) {
        gaugeBudget.setValue(gauge: spend, maxGauge: budget)
    }

    func showPeriod(period: Int, spend: Int) {
        gaugePeriod.setValue(gauge: Int64(spend), maxGauge: Int64(period))
    }

    func showMessage(message: String) {
        lbStatus.text = message
    }


}
