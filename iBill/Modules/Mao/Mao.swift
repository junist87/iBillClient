//
//  Mao.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 23..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class Mao {
    final let context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    final func commit() -> Bool{
        do {
            try context.save()
            NSLog("코어데이터 업데이트됨")
            return true
        } catch {
            context.rollback()
            NSLog("코어데이터 업데이트 실패")
            return false
        }
    }
    
    final func delete(mo: NSManagedObject) -> Bool {
        context.delete(mo)
        return self.commit()
    }
    
    final func getNewMo(_ entityName: String) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
    }
    
    final func deleteAll(entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                _ = self.delete(mo: managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
}
