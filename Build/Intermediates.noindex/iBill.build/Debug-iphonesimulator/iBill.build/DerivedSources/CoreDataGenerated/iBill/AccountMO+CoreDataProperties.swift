//
//  AccountMO+CoreDataProperties.swift
//  
//
//  Created by CiaoLee on 2018. 1. 25..
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension AccountMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountMO> {
        return NSFetchRequest<AccountMO>(entityName: "Account")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var regDate: Date?
    @NSManaged public var uuid: UUID?

}
