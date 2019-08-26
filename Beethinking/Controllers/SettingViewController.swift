//
//  SettingViewController.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/08/25.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit
import RealmSwift
import SCLAlertView

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didTapTextCreateNew(_ sender: UITapGestureRecognizer) {
        allDeleatData()
    }
    @IBAction func didTapIconCreateNew(_ sender: UITapGestureRecognizer) {
        allDeleatData()
    }
    
    func allDeleatData() {
        
        let alertView = SCLAlertView()
        alertView.addButton("はい") {
                    // (1)Realmインスタンスの生成
                    let realm = try! Realm()
                    // (2)全データの削除
                    try! realm.write {
                        realm.deleteAll()
                    }
        }
        alertView.showInfo(
            "すべてのデータが\n削除されます", // タイトル
            subTitle: "ほんとうに削除しますか", // サブタイトル
            closeButtonTitle: "いいえ", // クローズボタンのタイトル
            //                timeout: 2 , // **秒ごに、自動的に閉じる（OKでも閉じることはできる）
            colorStyle: 0xFF2600, // ボタン、シンボルの色
            colorTextButton: 0x000000, // ボタンの文字列の色
            //            circleIconImage: UIImage?, //アイコンimage
            animationStyle:.bottomToTop // スタイル（Success)指定
        )
    }
    

    @IBAction func didTextTapToAboutBeeThinking(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toAboutBeeThinking", sender: nil)
    }
    @IBAction func didTapToAboutBeeThinking(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toAboutBeeThinking", sender: nil)
    }
    
    
    @IBAction func didTextTapToAboutBeeSeries(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toAboutBeeSeries", sender: nil)
    }
    @IBAction func didTapToAboutBeeSeries(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toAboutBeeSeries", sender: nil)
    }
    
    
    @IBAction func didTextTapToAgreement(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toAgreement", sender: nil)
    }
    @IBAction func didTapToAgreement(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toAgreement", sender: nil)
    }
    
    
    
}
