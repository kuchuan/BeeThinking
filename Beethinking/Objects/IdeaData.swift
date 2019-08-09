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
    
    @objc dynamic var sentence: String = ""
    @objc dynamic var flick1: Int = 1
    
    @objc dynamic var flick2: Int = 1
    
    @objc dynamic var flick3: Int = 1
    
    @objc dynamic var flick4: Int = 1
    
    @objc dynamic var flick5: Int = 1
    
    @objc dynamic var flick6: Int = 1
    
    @objc dynamic var flick7: Int = 1
    
    @objc dynamic var flick8: Int = 1
    
    @objc dynamic var flick9: Int = 1
    
    @objc dynamic var flick10: Int = 1
    
    @objc dynamic var date: Date = Date()
}
