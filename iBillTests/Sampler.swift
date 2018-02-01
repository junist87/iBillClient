//
//  Sampler.swift
//  iBillTests
//
//  Created by CiaoLee on 2018. 1. 23..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import iBill


class Sampler {
    private var emailList = [String]()
    
    private let adverbWord: [String] = {
        let adverb: String = "착한 멋진 잘생긴 못생긴 더러운 이상한 죄스러운 복많은 사랑스러운 착한 제정신아닌 똑똑한"
        return adverb.components(separatedBy: " ")
    }()
    
    private let nounWord: [String] = {
        let noun: String = "강아지 사람 개 고양이 괴물 똥 코끼리 사자 호랑이 멍청이"
        return noun.components(separatedBy: " ")
    }()
    
    func getRandomEmail() -> String {
        var email = String()
        repeat {
            let first = self.getRandomString(size: 10)
            let mid = self.getRandomString(size: 10)
            let end = self.getRandomString(size: 3)
            
            email = "\(first)@\(mid).\(end)"
            NSLog(email)
        } while (emailList.contains(email))
        return email
    }
    
    func getRandomPasswd() -> String {
        return self.getRandomString(size: 10)
    }
    
    func getRandomString(size: Int) -> String {
        var string = String()
        for _ in 1 ... size {
            string.append(self.getRandomChar())
        }
        return string
    }
    
    private func getRandomChar() -> Character {
        let char: Int = Int (arc4random_uniform(25)) + 97
        return Character(UnicodeScalar(char)!)
    }
    
    
    func getRandomContents() -> String {
        let adverb = adverbWord[Int(arc4random_uniform(UInt32(adverbWord.count - 1)))]
        let noun = nounWord[Int(arc4random_uniform(UInt32(nounWord.count - 1)))]
        return adverb + " " + noun
    }
    
    func getSpend() -> Int64 {
        var budget = Int64(arc4random_uniform(900000) + 100000)
        budget = budget - (budget % 10000)
        return budget
    }
    
    func getUUID() -> UUID {
        return UUID()
    }
    
    func getRate() -> Float {
        return Float (arc4random())
    }
    
    func getRandDate() -> Date{
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
    
    func getRandDates() -> [Date] {
        var date1 = getRandDate()
        var date2 = getRandDate()
        
        if date1 > date2 {
            let tmp = date1
            date1 = date2
            date2 = tmp
        }
        
        return [date1, date2]
    }
    
    func getRandDouble() -> Double {
        return Double (arc4random())
    }
    
}
