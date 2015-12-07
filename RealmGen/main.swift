//
//  main.swift
//  RealmGen
//
//  Created by Tom Wilkinson on 12/5/15.
//  Copyright © 2015 Tom Wilkinson. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

var realmPath: String?
for var i in 1..<Process.arguments.count {
    switch Process.arguments[i] {
    case "-p":
        i++
        realmPath = Process.arguments[i]
    default:
        break
    }
}
let jsonFile = Process.arguments.last!
let url = NSURL.fileURLWithPath(jsonFile)
let data = NSData(contentsOfURL: url)
let dict = JSON(data: data!).dictionaryObject!
let modelName = dict["modelName"] as! String
let objects = dict["objects"] as! [[String: AnyObject]]
if let realmPath = realmPath {
    Realm.Configuration.defaultConfiguration.path = NSURL.fileURLWithPath(realmPath).path
}
let realm = try! Realm()
print("***** Writing to \(realm.path) *****")
try! realm.write() {
    for objectDict in objects {
        autoreleasepool {
            print("Creating \(modelName) with dict: \(objectDict)")
            realm.dynamicCreate(modelName, value: objectDict)
        }
    }
}