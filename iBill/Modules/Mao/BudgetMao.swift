//
//  BudgetMao.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 24..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import CoreData

public class BudgetMao: Mao {

    public func create(budget: Int64, content: String, type: UUID, stDate: Date, edDate: Date) -> UUID! {
        let budgetMO = super.getNewMo("Budget") as! BudgetMO
        
        budgetMO.budget = budget
        budgetMO.content = content
        budgetMO.type = type
        budgetMO.stDate = stDate
        budgetMO.edDate = edDate
        budgetMO.uuid = UUID()
        budgetMO.isUpload = false

        if super.commit() {
            return budgetMO.uuid
        } else {
            return nil
        }

    }
    
    public func read(uuid: UUID) -> (uuid: UUID, budget: Int64, content: String, type: UUID, stDate: Date, edDate: Date)! {
        let fetch: NSFetchRequest<BudgetMO> = BudgetMO.fetchRequest()
        let pred = NSPredicate(format: "uuid = %@", uuid as CVarArg)
        fetch.predicate = pred
        
        do {
            let resultSet = try super.context.fetch(fetch)
            if resultSet.count > 0  {
                // 옵셔너 체이닝
                let result = resultSet[0]
                if let content = result.content,
                    let type = result.uuid,
                    let stDate = result.stDate,
                    let edDate = result.edDate {
                    return (uuid: uuid, budget: result.budget, content: content, type: type, stDate: stDate, edDate: edDate)
                }
            }
        } catch {
        }
        // 검색실패시 nil 리턴
        return nil
    }
    
    
    public func update(uuid: UUID, budget: Int64, content: String, type: UUID, stDate: Date, edDate: Date) -> Bool {
        let fetch: NSFetchRequest<BudgetMO> = BudgetMO.fetchRequest()
        let pred = NSPredicate(format: "uuid = %@", uuid as CVarArg)
        fetch.predicate = pred
        
        do {
            let resultSet = try super.context.fetch(fetch)
            // 1개의 레코드만 불러와져야 한다.
            if resultSet.count == 1 {
                let result = resultSet[0]
                result.budget = budget
                result.content = content
                result.type = type
                result.stDate = stDate
                result.edDate = edDate
                return super.commit()
            }
        } catch {
        }
        return false
    }
    
    public func delete(uuid: UUID) -> Bool {
        let fetch: NSFetchRequest<BudgetMO> = BudgetMO.fetchRequest()
        let pred = NSPredicate(format: "uuid = %@", uuid as CVarArg)
        fetch.predicate = pred
        
        do {
            let resultSet = try super.context.fetch(fetch)
            super.delete(resultSet)
            return true
        } catch {
            return false
        }
    }
    
    
    
    
    
    public func getBudgetList(date: Date) -> [(uuid: UUID, budget: Int64, content: String, type: UUID, stDate: Date, edDate: Date)]! {
        let fetch: NSFetchRequest<BudgetMO> = BudgetMO.fetchRequest()
        let baseDate = date as CVarArg
        let pred = NSPredicate(format: "(stDate <= %@) AND (%@ <= edDate)", baseDate, baseDate)
        fetch.predicate = pred
        
        do {
            let resultSet = try! super.context.fetch(fetch)
            if resultSet.count != 0  {
                var list = [(uuid: UUID, budget: Int64, content: String, type: UUID, stDate: Date, edDate: Date)]()
                for result in resultSet {
                    // 옵셔너 체이닝
                    if let uuid = result.uuid,
                        let content = result.content,
                        let type = result.type,
                        let stDate = result.stDate,
                        let edDate = result.edDate {
                        list.append((uuid: uuid, budget: result.budget, content: content, type: type, stDate: stDate, edDate: edDate))
                    }
                }
                return list
            }
        }
        return nil
    }
    
    public func deleteAll() {
        super.deleteAll(entity: "Budget")
    }
}
