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
import AVFoundation
import GoogleMobileAds

class DeleatDateViewController: UIViewController {
    
    @IBOutlet weak var bannarViewDelete: GADBannerView!
    
    let admobId = "ca-app-pub-9383562194881432/7452199597"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bannarViewDelete.adUnitID = admobId
        bannarViewDelete.rootViewController = self
        bannarViewDelete.load(GADRequest())

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
//                let result = CreateIdea().createIdea(t・ext: "", tag: 100, autoSpredSwich: false)
                
                let realm = try! Realm()
                
                let count = realm.objects(IdeaData.self).filter("attributeId == \(generalAttributeId)")
                
                if count.count != 0 {
                    //データをリセットすることのトグルを設定してviewcontlloerに送る（senderでいいんじゃないの・・・わからんけど）
                    dataResetToggleFromDeleteData = true
                }
//
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
        
        //　中心課題にデータのゆ有無を下調べ
        // (1)Realmインスタンスの生成
        let realm = try! Realm()
        
        
        // 中心課題のデータを読み込んで渡す
        if realm.objects(IdeaData.self).filter("attributeId == \(generalAttributeId) AND tagNumber == 100").isEmpty {
//            print("deleteData\(#line)：中心課題がありません")
            SCLAlertView().showWarning(
                "中心課題が\n入力されていません", // タイトル
                subTitle: "最初の画面に戻ります", // サブタイトル
                closeButtonTitle: "OK", // クローズボタンのタイトル
                //                duration: 2 , // **秒ごに、自動的に閉じる（OKでも閉じることはできる）
                colorStyle: 0xFFCF2F, // ボタン、シンボルの色
                colorTextButton: 0x000000, // ボタンの文字列の色
                //            circleIconImage: UIImage?, //アイコンimage
                animationStyle: .bottomToTop // スタイル（Success)指定
            )
            self.performSegue(withIdentifier: "fromDeleteToMain", sender: nil)
            return
        } else {
            let centerHoneycomb = realm.objects(IdeaData.self).filter("attributeId == \(generalAttributeId) AND tagNumber == 100").reversed()

        
                let alertView = SCLAlertView()
                alertView.addButton("はい") {

                    
                    let result = CreateIdea().createIdea(text: "\(centerHoneycomb.first!.sentence)", tag: 100, autoSpredSwich: false)
                    
                    print(result)
                        honeycombTagNum = 100
                    
                        //dataResetToggleFromDeleteData = true　//自動で中心課題がコピーされてデータに書き込まれるので、ここは不要になりました
                    
                        self.performSegue(withIdentifier: "fromDeleteToMain", sender: nil)
                    }
                    alertView.showInfo(
                        "現在の\n中心課題をコピーして\n新規作成します", // タイトル
                        subTitle: "よろしいですか", // サブタイトル
                        closeButtonTitle: "いいえ", // クローズボタンのタイトル
                        //                timeout: 2 , // **秒ごに、自動的に閉じる（OKでも閉じることはできる）
                        colorStyle: 0xFFCF2F, // ボタン、シンボルの色
                        colorTextButton: 0x000000, // ボタンの文字列の色
                        //            circleIconImage: UIImage?, //アイコンimage
                        animationStyle:.bottomToTop // スタイル（Success)指定
                    )
        }
        
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
            
//            dataResetToggleFromDeleteData = true　//　全消去なので必要なしと。
            
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
