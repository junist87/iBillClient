//
//  BudgetMO+CoreDataProperties.swift
//  
//
//  Created by CiaoLee on 2018. 1. 25..
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension BudgetMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BudgetMO> {
        return NSFetchRequest<BudgetMO>(entityName: "Budget")
    }

    @NSManaged public var budget: Int64
    @NSManaged public var content: String?
    @NSManaged public var edDate: Date?
    @NSManaged public var isUpload: Bool
    @NSManaged public var stDate: Date?
    @NSManaged public var type: UUID?
    @NSManaged public var uuid: UUID?

}
