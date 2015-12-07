//
//  StaticTriggerRealm.swift
//  Wing
//
//  Created by Tom Wilkinson on 10/19/15.
//  Copyright © 2015 Sparo, Inc. All rights reserved.
//

import RealmSwift

class StaticTriggerRealm: Object {
    dynamic var name: String?
    dynamic var detail: String?
    dynamic var uuid = NSUUID().UUIDString
    
    /**
     - returns: Primary key for storage in Realm
     */
    override static func primaryKey() -> String? {
        return "uuid"
    }
}
