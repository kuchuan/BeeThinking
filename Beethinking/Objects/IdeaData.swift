//
//  IdeaData.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/08/04.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import RealmSwift

class IdeaData: Object {
    
    @objc dynamic var id: Int = 0
    
    @objc dynamic var attributeId: Int = 0
    
    @objc dynamic var tagNumber: Int = 0
    
    @objc dynamic var sentence: String = ""
    
    @objc dynamic var flickOpacity: Float = 1.0
    
    @objc dynamic var date: Date = Date()
}
