//
//  UserSettingViewController.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/08/29.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit
import RealmSwift
import SCLAlertView

class UserSettingViewController: UIViewController {
    
    
    @IBOutlet weak var changeInitial: UISwitch!
    @IBOutlet weak var changHoneycomb: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if initialSetGeneralAttributeIdToggle == true {
            changeInitial.isOn = true
        } else {
            changeInitial.isOn = false
        }
        
        if initialAutoSetOfDuplicateToggle == true {
            changHoneycomb.isOn = true
        } else {
            changHoneycomb.isOn = false
        }
        
        
    }
    
    @IBAction func didClickChangedInitial(_ sender: UISwitch) {
        
        //トグルスイッチが書き換わるとtrue、falseが初期化用のuserdefaultに書き込まれる
        if sender.isOn {
            initialSetGeneralAttributeIdToggle = true
        } else {
            initialSetGeneralAttributeIdToggle = false
        }
        // UserDefaultsを準備して、変数UserDefaultに入れる
        let userDefault = UserDefaults.standard
        //userDefault.set(保存する値, forKey: "保存する値")
        userDefault.set(initialSetGeneralAttributeIdToggle, forKey: "initialSetGeneralAttributeIdToggle")
        userDefault.set(generalAttributeId, forKey: "initialSetGeneralAttributeIdValue")
        userDefault.set(autoSetOfDuplicate, forKey: "initialAutoSetOfDuplicateToggle")
        
    }
    

    
    
    @IBAction func didClickCanged(_ sender: UISwitch) {
        //        label.text = "スイッチがクリックされたよ"
        //        print(sender.isOn)
        if sender.isOn {
            autoSetOfDuplicate = true
            initialAutoSetOfDuplicateToggle = true
        } else {
            autoSetOfDuplicate = false
            initialAutoSetOfDuplicateToggle = false
        }
        // UserDefaultsを準備して、変数UserDefaultに入れる
        let userDefault = UserDefaults.standard
        //userDefault.set(保存する値, forKey: "保存する値")
        userDefault.set(initialSetGeneralAttributeIdToggle, forKey: "initialSetGeneralAttributeIdToggle")
        userDefault.set(generalAttributeId, forKey: "initialSetGeneralAttributeIdValue")
        userDefault.set(autoSetOfDuplicate, forKey: "initialAutoSetOfDuplicateToggle")
    
    }
    
    
    @IBAction func didTapDeleteDateBase(_ sender: UITapGestureRecognizer) {
        allDeleteData()
    }
    @IBAction func didTapTextDeleteDateBase(_ sender: UITapGestureRecognizer) {
        allDeleteData()
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
            
            self.performSegue(withIdentifier: "fromUserSettingToMain", sender: nil)
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
