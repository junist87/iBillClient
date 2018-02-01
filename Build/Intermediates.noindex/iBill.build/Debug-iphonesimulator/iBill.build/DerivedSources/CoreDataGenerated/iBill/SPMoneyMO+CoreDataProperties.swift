//
//  SPMoneyMO+CoreDataProperties.swift
//  
//
//  Created by CiaoLee on 2018. 1. 25..
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension SPMoneyMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SPMoneyMO> {
        return NSFetchRequest<SPMoneyMO>(entityName: "SPMoney")
    }

    @NSManaged public var content: String?
    @NSManaged public var edDate: Date?
    @NSManaged public var id: String?
    @NSManaged public var isUpload: Bool
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var rate: Float
    @NSManaged public var spend: Int64
    @NSManaged public var spType: UUID?
    @NSManaged public var stDate: Date?
    @NSManaged public var uuid: UUID?

}
