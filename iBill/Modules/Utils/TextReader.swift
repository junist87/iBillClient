//
//  TextReader.swift
//  iBill
//
//  Created by CiaoLee on 2018. 1. 23..
//  Copyright © 2018년 CiaoLee. All rights reserved.
//

import Foundation


public class TextReader {
    func getText(filename: String) -> String! {
        
        if let path = Bundle.main.path(forResource: filename, ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                return data
            } catch  {
                return nil
            }
        }
        // 파일이 없으면 nil 리턴
        return nil
    }

}
