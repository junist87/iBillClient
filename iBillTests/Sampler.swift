//
//  Sampler.swift
//  iBillTests
//
//  Created by CiaoLee on 2018. 1. 23..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation

class Sampler {
    private var emailList = [String]()
    
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
}
