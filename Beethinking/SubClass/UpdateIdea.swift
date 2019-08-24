//
//  UpdateIdea.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/08/24.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import RealmSwift

class UpdateIdea {
    
    //インスタンス
    var autoSpredSwich = true
    
    
    //メソッド
    //最大のIDを取得するメソッド
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

    func updateIdea(text: String, tag: Int, autoSpredSwich: Bool) -> (Int, Int) {
    
        var idea = IdeaData()
        //更新
        let realm = try! Realm()
        
        var tmpTag: Int = 0
        
        if tag == 100 {
            tmpTag = 0
        } else {
            tmpTag = tag
        }
        
        //当該のデータを探す
        let result = realm.objects(IdeaData.self).filter("attributeId == \(generalAttributeId) AND tagNumber == \(tag)")
        idea = result.first!

        try! realm.write {
        idea.sentence = text
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
                
                let setIdea = CreateIdea()
                var res = (0, 0)
                
                //相手にデータが含まれていないことが前提だけど、先にあルことを想定して。
                let result = realm.objects(IdeaData.self)
                        .filter("attributeId == \(generalAttributeId) AND tagNumber == \(tmpTag)")

                if result.isEmpty {
                    //作成したideaを相手先に登録する（相手データがない場合：新規）
                    res = setIdea.createIdea(text: text, tag: tmpTag, autoSpredSwich: false)
                    print(#line, "アイデア新規作成", res, idea.sentence)
                } else {
                    //作成したideaを相手先に登録する（相手データがある場合：上書き）
                    res = self.updateIdea(text: text, tag: tmpTag, autoSpredSwich: false)
                    print(#line, "アイデア上書き", res, idea.sentence)
                }
                
            }
        }
        //　autoSetOfDuplicateがture（）
        return (tag, tmpTag)
    }

    
}
