//
//  main.swift
//  LogChinese_Swift
//
//  Created by yuelixing on 2016/11/24.
//  Copyright © 2016年 YueLiXing. All rights reserved.
//

import Foundation


var array = ["数组元素0", "数组元素1   ", 28] as [Any]
let dict = [
    "name": "asdh\n红",
    "array": array
] as [String : Any]

var dictM = NSMutableDictionary()
dictM.setObject(Test(), forKey: "newkey" as NSCopying)
dictM.setObject("啦啦", forKey: "name"as NSCopying)
dictM.setObject(NSException.init(name: ("异常" as NSCopying) as! NSExceptionName, reason: "reason", userInfo: ["name": "小红"]), forKey: "NSException" as NSCopying)
//    NSLog(@"%@", array);

Logger.info(array)
Logger.info(dict)
Logger.info(dictM)
//NSLog(@"%@", dictM);

