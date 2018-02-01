//
//  SPMoneyMao.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 25..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import CoreData

public class SPMoneyMao: Mao {
    public func create(spend: Int64, content: String, spType: UUID, rate: Float, stDate: Date, edDate: Date, lat: Double, lon: Double) -> UUID! {
        let spMoneyMO = super.getNewMo("SPMoney") as! SPMoneyMO
        
        spMoneyMO.uuid = UUID()
        spMoneyMO.spend = spend
        spMoneyMO.content = content
        spMoneyMO.spType = spType
        spMoneyMO.rate = rate
        spMoneyMO.stDate = stDate
        spMoneyMO.edDate = edDate
        spMoneyMO.lat = lat
        spMoneyMO.lon = lon
        spMoneyMO.isUpload = false
        
        if super.commit() {
            return spMoneyMO.uuid
        }
        return nil
    }
    
    public func read(uuid: UUID) -> (uuid: UUID, spend: Int64, content: String, spType: UUID, rate: Float,
        stDate: Date, edDate: Date, lat: Double, lon: Double, isUpload: Bool)!
    {
        // 값 추출
        guard let result = readMO(uuid: uuid) else {
            return nil
        }
        
        if let value = translate(resultSet: [result]) {
            return value[0]
        }
        return nil
    }
    
    public func readList(baseDate: Date) -> [(uuid: UUID, spend: Int64, content: String, spType: UUID, rate: Float,
        stDate: Date, edDate: Date, lat: Double, lon: Double, isUpload: Bool)]!
    {
        let fetch: NSFetchRequest<SPMoneyMO> = SPMoneyMO.fetchRequest()
        let date = baseDate as CVarArg
        let pred = NSPredicate(format: "(stDate <= %@) AND (%@ <= edDate)", date, date)
        fetch.predicate = pred
        
        do {
            let resultSet = try super.context.fetch(fetch)
            return translate(resultSet: resultSet)
        } catch  {
        }
        return nil
    }
    
    
    public func update(uuid: UUID, spend: Int64, spType: UUID, content: String, rate: Float, stDate: Date, edDate: Date, lat: Double, lon: Double) -> Bool
    {
        guard let result = readMO(uuid: uuid) else {
            return false
        }
        result.spend = spend
        result.content = content
        result.spType = spType
        result.rate = rate
        result.stDate = stDate
        result.edDate = edDate
        result.lat = lat
        result.lon = lon
        result.isUpload = false
        
        return super.commit()
    }
    
    public func delete(uuid: UUID) -> Bool {
        guard let result = readMO(uuid: uuid) else {
            return false
        }
        return super.delete(mo: result)
    }
    
    public func deleteAll() {
        super.deleteAll(entity: "SPMoney")
    }
    
    private func readMO(uuid: UUID) -> SPMoneyMO! {
        let fetch: NSFetchRequest<SPMoneyMO> = SPMoneyMO.fetchRequest()
        let pred = NSPredicate(format: "uuid = %@", uuid as CVarArg)
        fetch.predicate = pred
        
        do {
            let resultSet = try super.context.fetch(fetch)
            // uuid 는 언제나 1개라는 기준으로 출력한다
            if resultSet.count == 1 {
                return resultSet[0]
            }
        } catch {
        }
        return nil
    }
    
    private func translate(resultSet: [SPMoneyMO]) -> [(uuid: UUID, spend: Int64, content: String, spType: UUID, rate: Float,
        stDate: Date, edDate: Date, lat: Double, lon: Double, isUpload: Bool)]!
    {
        var list = [(uuid: UUID, spend: Int64, content: String, spType: UUID, rate: Float,
                     stDate: Date, edDate: Date, lat: Double, lon: Double, isUpload: Bool)]()
        for result in resultSet {
            guard let uuid = result.uuid, let content = result.content, let spType = result.spType,
                let stDate = result.stDate, let edDate = result.edDate else {
                    return nil
            }
            list.append((uuid: uuid, spend: result.spend, content: content, spType: spType, rate: result.rate,
                         stDate: stDate, edDate: edDate, lat: result.lat, lon: result.lon, isUpload: result.isUpload))
        }
        return list
    }
    
}
