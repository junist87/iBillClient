//
// Created by CiaoLee on 2018. 2. 11..
// Copyright (c) 2018 CiaoLee. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class UIMiniMap: UIView, MKMapViewDelegate, CLLocationManagerDelegate, UIPauseView, UIModalView {
    
    private let map = MKMapView()                       // 맵뷰
    private var locationManager = CLLocationManager()   // GPS 정보 객체
    private var nowLocation: CLLocation?                // 현재 위치
    var swtMoveFollowLocation: Bool = false      // 위치 이동에 따른 맵 이동 스위치
    var borderColor: UIColor {                   // 뷰의 Border 색상
        didSet (color)  {
            self.layer.borderColor = color.cgColor
        }
    }
    
    override var frame: CGRect {                        // 뷰의 프레임 변화시 UIs 재 배치
        didSet {
            self.allocateUIs()
        }
    }

    /* -- initializer -- */
    required init?(coder aDecoder: NSCoder) {
        fatalError("인터페이스빌더로 생성 불가능")
    }

    init() {
        borderColor = UIColor.gray

        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 100))  // 기본값
        
        // 맵 기본설정
        self.map.mapType = .standard
        self.map.isZoomEnabled = true
        self.map.isScrollEnabled = true
        self.map.showsUserLocation = true
        self.map.showsScale = false
        self.map.showsCompass = false
        self.map.delegate = self
        
        // 뷰어 기본설정
        self.layer.cornerRadius = 5
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
        self.layer.borderWidth = 2
        
        
        // CLLocationManager 설정
        locationManager.delegate = self                             // 델리게이션 패턴
        locationManager.desiredAccuracy = kCLLocationAccuracyBest   // 맵 정확성 설정
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()                     // GPS 정보 수신 시작한다, 권한설정은 나중에 프로그램 실행될때 한번에 물어본다.
        
        // UIs 등록
        self.addUIs()
    }
    
 
    
    /* -- UI Allocator -- */
    private func allocateUIs() {
        map.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }

    private func addUIs() {
        self.addSubview(map)
    }
    
    
    /* -- Method -- */
    // 맵을 지정한 곳으로 이동 하는 메소드
    func showLocation(latitude: Double, longitude: Double, zoom: Double) {
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        let distance: CLLocationDistance = zoom 
        let coordinate = MKCoordinateRegionMakeWithDistance(location, distance, distance)
        map.setRegion(coordinate, animated: true)
    }
    
    
    
    /* -- Delegation -- */
    // 움직일때마다 현재 좌표를 구해오는 델리게이션
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //NSLog("GPS 정보 수신중 \(locations.last)")
        self.unPause()
        self.nowLocation = locations.last   // 가장 최근의 위치를 파악해서 저장한다
        
        // 현재위치를 따라가는 스위치가 켜져 있으면 맵을 이동시킨다.
        if let location = nowLocation ,swtMoveFollowLocation {
            showLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 500)
        }
    }
    
    // 현재 위치를 파악하지 못했을때 작동하는 델리게이션
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog("GPS 수신 불가 : \(error)")
        self.pause(message: "GPS 수신 불가")
    }
    
    
}
