//
//  LogCategory.swift
//  LogChinese_Swift
//
//  Created by yuelixing on 2018/12/13.
//  Copyright © 2018 YueLiXing. All rights reserved.
//

import Foundation


extension Array {
    public var debugDescription: String { get {
        var descStr = "["
        self.forEach { (elem) in
            descStr.append("\"\(elem)\",\n")
        }
        descStr.append("]")
        return descStr
        }
    }
    var description: String { get {
        var descStr = "["
        self.forEach { (elem) in
            descStr.append("\"\(elem)\",\n")
        }
        descStr.append("]")
        return descStr
        }
    }
    
}
