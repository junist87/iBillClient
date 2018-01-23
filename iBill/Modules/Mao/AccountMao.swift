//
//  AccountMao.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 23..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import CoreData

class AccountMao: Mao{
    
    public func setAccount(email: String, passwd: String) -> Bool {
        let account =  super.getNewMo("Account") as! AccountMO
        
        account.email = email
        account.password = passwd
        account.uuid = UUID()
        account.regDate = Date()
        
        return super.commit()
    }
    
    public func getRecentlyAccount() -> (email: String, passwd: String, regDate: Date, uuid: UUID)? {
        let fetch: NSFetchRequest<AccountMO> = AccountMO.fetchRequest()
        let sort = NSSortDescriptor(key: "regDate", ascending: false)   // 최근데이터순으로 정렬
        fetch.sortDescriptors = [sort]
        
        do {
            let resultSet = try context.fetch(fetch)
            if resultSet.count == 0 {
                // 가저온 데이터가 없다면 nil 값을 리턴한다.
                return nil
            }
            let account = resultSet[0]
            return (account.email!, account.password!, account.regDate!, account.uuid!)
        } catch {
            // 기타 예외 사항이 생기면 nil 값을 리턴한다.
            return nil
        }
    }
    
    
    public func deleteAllAccountMO() {
        super.deleteAll(entity: "Account")
    }
    
}
