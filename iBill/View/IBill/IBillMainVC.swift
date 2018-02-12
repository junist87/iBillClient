//
//  IBillMainVC.swift
//  iBill
//
//  Created by CiaoLee on 2018. 2. 9..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class IBillMainVC: UIViewController, UIModalView {
    //let characterView = UICharacterView()
    let mapView = UIMiniMap()


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        setDefault()
    }

    private func setDefault() {
        self.view.backgroundColor = UIColor.white

        //characterView.frame = CGRect(x: 10, y: 100, width: 200, height: 80)
        //self.view.addSubview(characterView)
        
        mapView.frame = CGRect(x: 10, y: 300, width: 300, height: 300)
        mapView.swtMoveFollowLocation = true
        
        
        let button = UIBasicButton(label: "Bottom", borderColor: UIColor.orange, labelColor: UIColor.gray)
        button.frame = CGRect(x: 100, y: 300, width: 60, height: 60)
        button.addTarget(self, action: #selector(btModal), for: UIControlEvents.touchUpInside)

        view.addSubview(button)
        
        let buttonTwo = UIBasicButton(label: "Center", borderColor: UIColor.orange, labelColor: UIColor.gray)
        buttonTwo.frame = CGRect(x: 200, y: 300, width: 60, height: 60)
        buttonTwo.addTarget(self, action: #selector(btCenterModal), for: UIControlEvents.touchUpInside)
        
        view.addSubview(buttonTwo)
        
        
        
    }
    @objc func btCenterModal() {
        showModalView(view: mapView, modalStyle: .center)
    }
    
    @objc func btModal() {
        showModalView(view: mapView, modalStyle: .bottom)
    }


}
