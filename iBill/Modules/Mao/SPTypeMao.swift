//
//  SPTypeMao.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 24..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import CoreData

public class SPTypeMao: Mao {
    public func create(icon:UUID, content: String, price: Int64) -> Bool {
        let spType = super.getNewMo("SPType") as! SPTypeMO
        
        spType.uuid = UUID()
        spType.icon = icon
        spType.content = content
        spType.price = price
        
        return super.commit()
    }
    
    public func read(uuid: UUID) -> (icon: UUID, content: String, price: Int64)! {
        guard let resultSet = self.readMO(uuid: uuid) else {
            return nil
        }
        
        if resultSet.count == 1 {
            let rcd = resultSet[0]
            if let icon = rcd.icon, let content = rcd.content {
                return (icon: icon, content: content, rcd.price)
            }
        }
        return nil
    }
    
    public func update(uuid: UUID, icon:UUID, content: String, price: Int64) -> Bool {
        guard let resultSet = self.readMO(uuid: uuid) else {
            return false
        }
        
        if resultSet.count == 1 {
            let rcd = resultSet[0]
            rcd.icon = icon
            rcd.content = content
            rcd.price = price
            return super.commit()
        }
        return false
    }
    
    public func delete(uuid: UUID) -> Bool{
        guard let resultSet = readMO(uuid: uuid) else {
            return false
        }
        super.delete(resultSet)
        return true
    }
    
    private func readMO(uuid: UUID) -> [SPTypeMO]! {
        let fetch: NSFetchRequest<SPTypeMO> = SPTypeMO.fetchRequest()
        let pred = NSPredicate(format: "uuid = %@", uuid as CVarArg)
        fetch.predicate = pred
        
        do {
            let resultSet = try super.context.fetch(fetch)
            return resultSet
        } catch {
        }
        
        return nil
    }
}
