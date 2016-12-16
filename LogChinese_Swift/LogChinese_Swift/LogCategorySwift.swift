//
//  LogCategorySwift.swift
//  LogChinese_Swift
//
//  Created by yuelixing on 2016/12/16.
//  Copyright © 2016年 YueLiXing. All rights reserved.
//

import Foundation

extension Array {
    public var description: String {
        get {
            var targetString = String()
            targetString.append("[\n")
            self.forEach { item in
                targetString.append("\t")
                switch item {
                case is Int,is Int8,is Int16,is Int32,is Int64,is Integer:
                    targetString.append("Int: \(item)")
                case is Float,is Float80,is CGFloat:
                    targetString.append("Float: \(item)")
//                    Logger.info("Int: \(item)")
                case is Double:
                    targetString.append("Double: \(item)")
                case is String:
                    let temp = item as! String
                    let tempString = temp.replacingOccurrences(of: "\n", with: "\n\t")
                    targetString.append("String: \"\(tempString)\"")
//                    Logger.info("String: \(item)")
                case is Bool:
                    targetString.append("Bool: \(item)")
//                    Logger.info("Bool: \(item)")
                case is Dictionary<String, Any>:
                    let tempArray = item as! Dictionary<String, Any>
                    let tempString = tempArray.description.replacingOccurrences(of: "\n", with: "\n\t")
                    targetString.append("Dictionary<String, Any>: \(tempString)")
                case is Array:
                    let tempArray = item as! Array
                    let tempString = tempArray.description.replacingOccurrences(of: "\n", with: "\n\t")
                    targetString.append("Array: \(tempString)")
//                    Logger.info("Array: \(tempString)")
                case is NSObject:
                    let tempObj = item as! NSObject
                    targetString.append("\(tempObj.className): \(item)")
//                    Logger.info("NSObject: \(item)")
                default:
                    targetString.append("UnKnown: \(item)")
//                    Logger.info(item)
                }
                targetString.append("\n")
            }
            targetString.append("]")

            return targetString
        }
    }
    public var debugDescription: String {
        get {
            return self.description
        }
    }
}


extension Dictionary {
    public var description: String {
        get {
            var targetString = String()
            targetString.append("[\n")
            self.forEach { (key, value) in
                targetString.append("\t")
                targetString.append(String.init(describing: key))
                targetString.append(" : ")
                switch value {
                case is Int:
                    targetString.append("\(value)")
//                    Logger.info("Int: \(value)")
                case is String:
                    let temp = value as! String
                    let tempString = temp.replacingOccurrences(of: "\n", with: "\n\t")
                    targetString.append("\"\(tempString)\"")
//                    Logger.info("String: \(value)")
                case is Bool:
                    targetString.append("\(value)")
//                    Logger.info("Bool: \(value)")
                case is Dictionary<String, Any>:
                    let tempArray = value as! Dictionary<String, Any>
                    let tempString = tempArray.description.replacingOccurrences(of: "\n", with: "\n\t")
                    targetString.append("\(tempString)")
//                    Logger.info("Array: \(tempString)")
                case is Array<Any>:
                    let tempArray = value as! Array<Any>
                    let tempString = tempArray.description.replacingOccurrences(of: "\n", with: "\n\t")
                    targetString.append("\(tempString)")
//                    Logger.info("Array: \(tempString)")
                case is NSObject:
                    targetString.append("\(value)")
//                    Logger.info("NSObject: \(value)")
                default:
                    targetString.append("\(value)")
//                    Logger.info(value)
                }
                targetString.append("\n")
            }
            targetString.append("]")

            return targetString
        }
    }
    public var debugDescription: String {
        get {
            return self.description
        }
    }
}
