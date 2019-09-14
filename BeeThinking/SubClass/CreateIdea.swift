//
//  CreateIdea.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/08/24.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import RealmSwift

class CreateIdea {
    
    //インスタンス
    var autoSpredSwich = true
    
    
    //メソッド
    //最大のIDを取得するメソッド
    func getMaxId() -> Int {
        //Realmに接続
        let realm = try! Realm()
        
        // Todoのシートから最大のIDを取得する(asはInt型に変える?はnilを許容する）
        let id = realm.objects(IdeaData.self).max(ofProperty: "id") as Int?
        
        if id == nil {
            //最大IDがnil存在しない場合は、1を返す
            return 1
        } else {
            return id! + 1
        }
        
    }
    
    func createIdea(text: String, tag: Int, autoSpredSwich: Bool) -> (Int, Int) {

        //Realmに接続
        let realm = try! Realm()
        //空文字でなければ、データを登録する
        var idea = IdeaData()
        
        var tmpTag: Int = 0
        
        if tag == 100 {
            tmpTag = 0
        } else {
            tmpTag = tag
        }
        
        
        //最大のIDを取得
        let id = getMaxId() as Int
        idea.id = id
        if tag == 100 {
            idea.attributeId = id
            generalAttributeId = id
        } else {
            //中心課題のIDを入れる必要がある
            idea.attributeId = generalAttributeId
        }
        idea.tagNumber = tag
        idea.groupAttributeId = Int(floor(Double(tmpTag) / 10)) 
        idea.sentence = text
        idea.flickOpacity = 1.0
        idea.date = Date()
        
        //作成したideaを登録する
        try! realm.write {
            realm.add(idea)
        }
        
        //　autoSpredSwichがture（）
        if autoSpredSwich {
            
            if (tag % 10 == 0 && tag != 100 ) || ( tag <= 6 && tag > 0 ) {
                if tag > 6 && tag < 100 {
                    //周辺課題エリアから中央課題エリアへのデータ入力
                    tmpTag = tag / 10
                } else {
                    //周辺課題エリアでのデータ入力
                    tmpTag = tag * 10
                }
                
                //相手にデータが含まれていないことが前提だけど、先にあルことを想定して。
                let result = realm.objects(IdeaData.self).filter("attributeId == \(generalAttributeId) AND tagNumber == \(tmpTag)")
        
                if result.isEmpty {
                    
                    let res = self.createIdea(text: text, tag: tmpTag, autoSpredSwich: false)
//                    print(#line, "アイデア新規作成",res,idea.sentence)
                    
                } else {
                
                    let setIdeas = UpdateIdea()
                    let res = setIdeas.updateIdea(text: text, tag: tmpTag, autoSpredSwich: false)
//                    print(#line, "アイデア上書き",res,idea.sentence)
                }
            
            }
//            print (#line,"CreateClass",generalAttributeId)
            
            
        }
    //　autoSetOfDuplicateがture（）
    return (tag, tmpTag)
    }

    


    
    
}
