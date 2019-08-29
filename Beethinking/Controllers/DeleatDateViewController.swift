//
//  DeleatDateViewController.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/08/26.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit
import RealmSwift
import SCLAlertView

class DeleatDateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func didTapIconCreateNew(_ sender: UITapGestureRecognizer) {
        createNewDate()
    }
    @IBAction func didTapTextCreateNew(_ sender: UITapGestureRecognizer) {
        createNewDate()
    }
    
    @IBAction func didTapIconRemoveAround(_ sender: UITapGestureRecognizer) {
        aroundDeleteData()
    }
    @IBAction func didTapTextRemovewAround(_ sender: UITapGestureRecognizer) {
        aroundDeleteData()
    }
    
    @IBAction func didTapIconDeleteDataBase(_ sender: UITapGestureRecognizer) {
        allDeleteData()
    }
    @IBAction func didTapTextDeleteDataBase(_ sender: UITapGestureRecognizer) {
        allDeleteData()
    }
    
    
    
    
    func createNewDate() {
        
        let alertView = SCLAlertView()
            alertView.addButton("はい") {
                let result = CreateIdea().createIdea(text: "", tag: 100, autoSpredSwich: false)
                
                //データをリセットすることのトグルを設定してviewcontlloerに送る（senderでいいんじゃないの・・・わからんけど）
                dataResetToggle = true
                
                self.performSegue(withIdentifier: "fromDeleteToMain", sender: nil)
            }
        alertView.showInfo(
            "新しい問題に\n取り組みます", // タイトル
            subTitle: "よろしいですか", // サブタイトル
            closeButtonTitle: "いいえ", // クローズボタンのタイトル
            //                timeout: 2 , // **秒ごに、自動的に閉じる（OKでも閉じることはできる）
            colorStyle:  0xFFCF2F, // ボタン、シンボルの色
            colorTextButton: 0x000000, // ボタンの文字列の色
            //            circleIconImage: UIImage?, //アイコンimage
            animationStyle:.bottomToTop // スタイル（Success)指定
        )

    }
    
    
    
    func aroundDeleteData()  {
        let alertView = SCLAlertView()
        alertView.addButton("はい") {
            // (1)Realmインスタンスの生成
            let realm = try! Realm()
            
            // 中心課題のデータを読み込んで渡す
            let centerHoneycomb = realm.objects(IdeaData.self).filter("attributeId == \(generalAttributeId) AND tagNumber == 100").reversed()
            
            let result = CreateIdea().createIdea(text: "\(centerHoneycomb.first!.sentence)", tag: 100, autoSpredSwich: false)
            
//            //（2）中心課題以外のクエリーを作成
//            let result = realm.objects(IdeaData.self).filter("attributeId == \(generalAttributeId) AND tagNumber >= 0 AND tagNumber <= 99").sorted(byKeyPath: "tagNumber", ascending: false).reversed()
//
//            // (3)当該データの削除
//            try! realm.write {
//                realm.delete(result) //デリーと
//            }
            honeycombTagNum = 100
            
            dataResetToggle = true
            
            self.performSegue(withIdentifier: "fromDeleteToMain", sender: nil)
        }
        alertView.showInfo(
            "現在の\n中心課題をコピーして\n新規作成します", // タイトル
            subTitle: "「周辺課題」と「アイデア」は\n削除しますか", // サブタイトル
            closeButtonTitle: "いいえ", // クローズボタンのタイトル
            //                timeout: 2 , // **秒ごに、自動的に閉じる（OKでも閉じることはできる）
            colorStyle: 0xFFCF2F, // ボタン、シンボルの色
            colorTextButton: 0x000000, // ボタンの文字列の色
            //            circleIconImage: UIImage?, //アイコンimage
            animationStyle:.bottomToTop // スタイル（Success)指定
        )
    }
    
    
    
    func allDeleteData() {
        
        let alertView = SCLAlertView()
        alertView.addButton("はい") {
            // (1)Realmインスタンスの生成
            let realm = try! Realm()
            // (2)全データの削除
            try! realm.write {
                realm.deleteAll()
            }
            
            honeycombTagNum = 100
            
            self.performSegue(withIdentifier: "fromDeleteToMain", sender: nil)
        }
        alertView.showInfo(
            "すべてのデータが\n削除されます\nこの操作は\n元に戻せません", // タイトル
            subTitle: "ほんとうに削除しますか", // サブタイトル
            closeButtonTitle: "いいえ", // クローズボタンのタイトル
            //                timeout: 2 , // **秒ごに、自動的に閉じる（OKでも閉じることはできる）
            colorStyle: 0xFF2600, // ボタン、シンボルの色
            colorTextButton: 0x000000, // ボタンの文字列の色
            //            circleIconImage: UIImage?, //アイコンimage
            animationStyle:.bottomToTop // スタイル（Success)指定
        )
    }
    
    
    
    
}
