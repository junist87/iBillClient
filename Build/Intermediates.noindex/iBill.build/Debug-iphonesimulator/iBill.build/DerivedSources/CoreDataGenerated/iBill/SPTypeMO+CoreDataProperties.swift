//
//  SPTypeMO+CoreDataProperties.swift
//  
//
//  Created by CiaoLee on 2018. 1. 25..
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension SPTypeMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SPTypeMO> {
        return NSFetchRequest<SPTypeMO>(entityName: "SPType")
    }

    @NSManaged public var content: String?
    @NSManaged public var icon: UUID?
    @NSManaged public var price: Int64
    @NSManaged public var uuid: UUID?

}
