//
//  PrivacyAsker.swift
//  iBill
//
//  Created by CiaoLee on 2018. 2. 12..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import MapKit

class PrivacyAsker {
    func askLocation() -> CLAuthorizationStatus{
        // 위치기반 서비스 인증 받기
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined  {
            CLLocationManager().requestWhenInUseAuthorization()
        }
        return status
    }
}
