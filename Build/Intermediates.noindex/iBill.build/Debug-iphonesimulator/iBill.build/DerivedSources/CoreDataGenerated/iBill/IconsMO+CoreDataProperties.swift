//
//  IconsMO+CoreDataProperties.swift
//  
//
//  Created by CiaoLee on 2018. 1. 25..
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension IconsMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IconsMO> {
        return NSFetchRequest<IconsMO>(entityName: "Icons")
    }

    @NSManaged public var fileId: String?
    @NSManaged public var filename: String?
    @NSManaged public var name: String?
    @NSManaged public var size: Int32
    @NSManaged public var uuid: UUID?

}
