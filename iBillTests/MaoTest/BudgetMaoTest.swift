//
//  BudgetMaoTest.swift
//  iBillTests
//
//  Created by CiaoLee on 2018. 1. 24..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import XCTest
@testable import iBill

class BudgetMaoTest: XCTestCase {

    var budgetMao: BudgetMao!
    
    override func setUp() {
        super.setUp()
        budgetMao = BudgetMao()
        budgetMao.deleteAll()
    }
    
    override func tearDown() {
        super.tearDown()
        budgetMao = nil
    }

    func testAddAndGet() {

    }

    /* -------------------------------------------------------- */
    func testAddAndGetList() {
        
        let testSize = 100
        let writeList = writeRandomRcd(size: testSize)
        
        NSLog("Add Rcd Count : \(writeList.count)")
        
        for _ in 0 ..< testSize {
            let targetDate = getRandomDate()
            let getTestRcd = pickDateRcd(list: writeList, baseDate: targetDate)
            guard let getRcd = budgetMao.getBudgetList(date: targetDate) else {
                XCTFail()
                return
            }
            
            NSLog("Basedate = \(targetDate)")
            NSLog("getRcd.count = \(getRcd.count), getTestRcd.count = \(getTestRcd.count)")
            
            
            for i in 0 ..< getRcd.count {
                let rcd = getRcd[i]
                for j in 0 ..< getTestRcd.count {
                    let testRcd = getTestRcd[j]
                    // 완전히 매칭되는 데이터가 존재시 다음 레코드 검사
                    if testRcd.budget == rcd.budget
                        && testRcd.content == rcd.content
                        && testRcd.stDate == rcd.stDate
                        && testRcd.edDate == rcd.edDate {
                        break
                    }
                    // 마지막 레코드까지 검색하였는데 매칭이 안되면 실패
                    if j == getTestRcd.count - 1 {
                        XCTFail()
                    }
                }
            }
        }
    }
    
    func writeRandomRcd(size: Int) -> [(budget: Int64, content: String, type: UUID, stDate: Date, edDate: Date)] {
        var list = [(budget: Int64, content: String, type: UUID, stDate: Date, edDate: Date)]()
        for _ in 0 ..< size {
            let getRcd = getBudgetRcd()
            NSLog("BudgetRcd : budget = \(getRcd.budget), content = \(getRcd.content), stDate = \(getRcd.stDate), edDate = \(getRcd.edDate)")
            _ = budgetMao.create(budget: getRcd.budget, content: getRcd.content, type: getRcd.type, stDate: getRcd.stDate, edDate: getRcd.edDate)
            list.append((budget: getRcd.budget, content: getRcd.content, type: getRcd.type, stDate: getRcd.stDate, edDate: getRcd.edDate))
        }
        return list
    }
    
    func pickDateRcd(list: [(budget: Int64, content: String, type: UUID, stDate: Date, edDate: Date)], baseDate: Date)
        -> [(budget: Int64, content: String, type: UUID, stDate: Date, edDate: Date)] {
        
        var picked = [(budget: Int64, content: String, type: UUID, stDate: Date, edDate: Date)]()
        for i in 0 ..< list.count {
            let rcd = list[i]
            if rcd.stDate <= baseDate && baseDate <= rcd.edDate {
                picked.append(rcd)
            }
        }
        return picked
    }
    
    
    
    func getBudgetRcd() -> (budget: Int64, content: String, type: UUID, stDate: Date, edDate: Date) {
        let sampler = Sampler()
        let budget = getRandomBudget()
        let content = sampler.getRandomContents()
        let type = UUID()
        let date = getRandomRangeDate()
        
        return (budget: budget, content: content, type: type, stDate: date[0], edDate: date[1])
    }

    func getRandomBudget() -> Int64 {
        var budget = Int64(arc4random_uniform(900000) + 100000)
        budget = budget - (budget % 10000)
        return budget
    }

    
    func getRandomRangeDate() -> [Date] {
        var date1 = getRandomDate()
        var date2 = getRandomDate()
        
        if date1 > date2 {
            let tmp = date1
            date1 = date2
            date2 = tmp
        }
        
        return [date1, date2]
    }

    func getRandomDate() -> Date{
        let signYear: Int = Double (arc4random()) <= 0.5 ? 1 :  -1
        let year: Int = Int (arc4random_uniform(10)) * signYear
        
        let signMonth: Int = Double (arc4random()) <= 0.5 ? 1 : -1
        let month: Int = Int (arc4random_uniform(12)) * signMonth
        
        let signDay: Int = Double (arc4random()) <= 0.5 ? 1 : -1
        let day: Int = Int (arc4random_uniform(30)) * signDay
        
        let dateUtils = DateUtils()
        let randomDate = dateUtils.getCalcDate(year: year, month: month, day: day, hour: 0, min: 0, sec: 0, baseDate: dateUtils.getToday())

        return randomDate
    }

    /* -------------------------------------------------------- */




}
