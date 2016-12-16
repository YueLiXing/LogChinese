//
//  main.swift
//  LogChinese_Swift
//
//  Created by yuelixing on 2016/11/24.
//  Copyright © 2016年 YueLiXing. All rights reserved.
//

import Foundation

let tempDouble = Double(20.099)
let tempFloat = Float(tempDouble)
let tempInt8 = Int8(tempDouble)

var array = [NSString.init(format: "test:%d", 23),"数组\n元素0", "数组元素1   ", 28, Test(), true, tempInt8, tempFloat, tempDouble] as [Any]
let dict = [
    "name": "asdh\n红",
    "array": array
] as [String : Any]

var dictM = NSMutableDictionary()
dictM.setObject(Test(), forKey: "newkey" as NSCopying)
dictM.setObject("啦啦", forKey: "name"as NSCopying)
dictM.setObject(NSException.init(name: ("异常" as NSCopying) as! NSExceptionName, reason: "reason", userInfo: ["name": "小红"]), forKey: "NSException" as NSCopying)
//    NSLog(@"%@", array);

let tempArray = NSArray(objects: "1", "2", "小红123")

array.append([
    "name": "小干红",
    "age": 23
])

array.append([1,2,3,5,[6,7,8,[9,0]]])
//array.des
Logger.info(array)
Logger.info(array.description)
//Logger.info(array.debugDescription)
//Logger.info(dict.description)
//Logger.info(dictM)
//NSLog(@"%@", dictM);
