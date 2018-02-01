//
//  IconsMao.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 23..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation
import CoreData

public class IconsMao: Mao {
    // iconList.txt
    /*
     *  파일규칙
     *  FileId FileName Name Size\n
     */
    
    public func importIconList() {
        let reader = TextReader()
        guard let whole = reader.getText(filename: "iconList") else {
            return
        }
        
        // 개행문자 기준으로 자르기
        let list = whole.components(separatedBy: "\n")
        
        for line in list {
            
            NSLog("Line \(line)")
            let component = line.components(separatedBy: " ")
            // 남은 문자가 4마디 보다 적으면 읽기를 중단한다
            if (component.count < 4) {
                break
            }
            let fileId = component[0]
            let filename = component[1]
            let name = component[2]
            let size = Int(component[3])
            _ = self.create(fileId: fileId, filename: filename, name: name, size: size!)
        }
    }
    
    public func create(fileId: String, filename: String, name: String, size: Int) -> Bool {
        let iconsMO = super.getNewMo("Icons") as! IconsMO
        
        iconsMO.fileId = fileId
        iconsMO.filename = filename
        iconsMO.name = name
        iconsMO.size = Int32 (size)
        iconsMO.uuid = UUID()
        
        return super.commit()
    }
    
    public func read(fileId: String) -> (filename: String, name: String, size: Int)! {
        let fetch: NSFetchRequest<IconsMO> = IconsMO.fetchRequest()
        let pred = NSPredicate(format: "fileId = %@", fileId)
        fetch.predicate = pred
        
        do {
            let resultSet = try context.fetch(fetch)
            if resultSet.count == 0 {
                // 가저온 데이터가 없다면 nil 값을 리턴한다.
                return nil
            } else {
                // 가저온 데이터중 첫번째 레코드를 출력한다.
                let icon = resultSet[0]
                // 옵셔너 체이닝
                if let filename = icon.filename, let name = icon.name {
                    return (filename, name, Int (icon.size))
                }
                return nil
            }
        } catch {
            // 기타 예외 사항이 생기면 nil 값을 리턴한다.
            return nil
        }
    }
    
    public func deleteAll() {
        super.deleteAll(entity: "Icons")
    }
}
