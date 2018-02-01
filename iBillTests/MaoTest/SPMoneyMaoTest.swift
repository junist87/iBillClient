//
//  SPMoneyMaoTest.swift
//  iBillTests
//
//  Created by CiaoLee on 2018. 1. 25..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import XCTest
@testable import iBill

class SPMoneyMaoTest: XCTestCase {
    var spMoneyMao: SPMoneyMao!
    var sampler: Sampler!
    
    override func setUp() {
        super.setUp()
        spMoneyMao = SPMoneyMao()
        sampler = Sampler()
        spMoneyMao.deleteAll()
    }
    
    override func tearDown() {
        super.tearDown()
        spMoneyMao = nil
    }
    
    func testCreateRead() {
        let testSize = 100
        
        // 임의의 값 불러오기
        let list = writeRandRcd(size: testSize)
        
        // 값비교
        self.compare(list: list)
    }
    
    func testUpdate() {
        let testSize = 100
        // 임의의 값 불러오기
        var list = writeRandRcd(size: testSize)
        
        // 값 수정하기
        for (uuid, _) in list {
            let spend = sampler.getSpend()
            let content = sampler.getRandomContents()
            let spType = sampler.getUUID()
            let rate = sampler.getRate()
            
            let dates = sampler.getRandDates()
            let stDate = dates[0]
            let edDate = dates[1]
            
            let lat = sampler.getRandDouble()
            let lon = sampler.getRandDouble()
            
            // 리스트에 저장
            list[uuid] = (spend: spend, content: content, spType: spType, rate: rate, stDate: stDate, edDate: edDate, lat: lat, lon: lon)
            
            // 수정하기
            _ = spMoneyMao.update(uuid: uuid, spend: spend, spType: spType, content: content, rate: rate, stDate: stDate, edDate: edDate, lat: lat, lon: lon)
        }
        
        self.compare(list: list)
    }
    
    
    public func testDelete() {
        let testSize = 100
        let list = self.writeRandRcd(size: testSize)
        for (uuid, _) in list {
            if !spMoneyMao.delete(uuid: uuid) {
                XCTFail()
            }
        }
    }
    
    public func testReadList() {
        let testSize = 100
        
        let list = writeRandRcd(size: testSize)
        
        for _ in 0 ..< testSize {
            let baseDate = sampler.getRandDate()
            let extractList = self.extractDateList(baseDate: baseDate, list: list)
            guard let getList = spMoneyMao.readList(baseDate: baseDate) else {
                XCTFail()
                break
            }
            for param in getList {
                guard let getRcd = extractList[param.uuid] else {
                    // 찾을수 없으면 실패
                    XCTFail()
                    break
                }
                XCTAssertEqual(param.content, getRcd.content)
                XCTAssertEqual(param.edDate, getRcd.edDate)
                XCTAssertEqual(param.lat, getRcd.lat)
                XCTAssertEqual(param.lon, getRcd.lon)
                XCTAssertEqual(param.rate, getRcd.rate)
                XCTAssertEqual(param.spend, getRcd.spend)
                XCTAssertEqual(param.spType, getRcd.spType)
                XCTAssertEqual(param.stDate, getRcd.stDate)
            }
        }
        
    }
    
    private func extractDateList(baseDate: Date, list: [UUID : (spend: Int64, content: String, spType: UUID, rate: Float, stDate: Date, edDate: Date, lat: Double, lon: Double)]) -> [UUID : (spend: Int64, content: String, spType: UUID, rate: Float, stDate: Date, edDate: Date, lat: Double, lon: Double)]  {
        
        var pickList = [UUID : (spend: Int64, content: String, spType: UUID, rate: Float, stDate: Date, edDate: Date, lat: Double, lon: Double)]()
        
        for (uuid, param) in list {
            if param.stDate <= baseDate && baseDate <= param.edDate {
                pickList[uuid] = param
                
            }
        }
        
        return pickList
    }
    
    
    
    private func writeRandRcd(size: Int) -> [UUID : (spend: Int64, content: String, spType: UUID, rate: Float, stDate: Date, edDate: Date, lat: Double, lon: Double)]
    {
        var list = [UUID : (spend: Int64, content: String, spType: UUID, rate: Float, stDate: Date, edDate: Date, lat: Double, lon: Double)]()
        for _ in 0 ..< size {
            let rcd = getRandRcd()
            guard let uuid = spMoneyMao.create(spend: rcd.spend, content: rcd.content, spType: rcd.spType, rate: rcd.rate, stDate: rcd.stDate, edDate: rcd.edDate, lat: rcd.lat, lon: rcd.lon) else {
                XCTFail()
                continue
            }
            // 값 추가
            list[uuid] = rcd
        }
        return list
    }
    
    private func compare(list: [UUID : (spend: Int64, content: String, spType: UUID, rate: Float, stDate: Date, edDate: Date, lat: Double, lon: Double)]) {
        
        for (uuid, param) in list {
            guard let getRcd = spMoneyMao.read(uuid: uuid) else {
                //데이터를 불러오지 못하면 실패
                XCTFail()
                continue
            }
            XCTAssertEqual(param.content, getRcd.content)
            XCTAssertEqual(param.edDate, getRcd.edDate)
            XCTAssertEqual(param.lat, getRcd.lat)
            XCTAssertEqual(param.lon, getRcd.lon)
            XCTAssertEqual(param.rate, getRcd.rate)
            XCTAssertEqual(param.spend, getRcd.spend)
            XCTAssertEqual(param.spType, getRcd.spType)
            XCTAssertEqual(param.stDate, getRcd.stDate)
        }
        
    }
    
    private func getRandRcd() -> (spend: Int64, content: String, spType: UUID, rate: Float, stDate: Date, edDate: Date, lat: Double, lon: Double) {
        let spend = sampler.getSpend()
        let content = sampler.getRandomContents()
        let spType = sampler.getUUID()
        let rate = sampler.getRate()
        
        let dates = sampler.getRandDates()
        let stDate = dates[0]
        let edDate = dates[1]
        
        let lat = sampler.getRandDouble()
        let lon = sampler.getRandDouble()
        
        return (spend: spend, content: content, spType: spType, rate: rate, stDate: stDate, edDate: edDate, lat: lat, lon: lon)
        
    }
    
}
