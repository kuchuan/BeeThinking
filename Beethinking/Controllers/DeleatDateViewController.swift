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
    }
    @IBAction func didTapTextCreateNew(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func didTapIconRemoveAround(_ sender: UITapGestureRecognizer) {
    }
    @IBAction func didTapTextRemovewAround(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func didTapIconDeleatDataBase(_ sender: UITapGestureRecognizer) {
        allDeleatData()
    }
    @IBAction func didTapTextDeleatDataBase(_ sender: UITapGestureRecognizer) {
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
            
            honeycombTagNum = 100
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
    
    

}
