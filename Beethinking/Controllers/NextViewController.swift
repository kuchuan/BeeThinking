//
//  NextViewController.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/07/28.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit
import Koloda
import RealmSwift



class NextViewController: UIViewController {
    
    
    @IBOutlet weak var kolodaView: KolodaView!
    
    var ideas: [IdeaData] = []
    var lists: [String] = []
    var swipeResults: [Float] = []
    
    var nvTagNumber: Int = 0
    
    var tmpTagArry: [Int] = []
    var tmpOpcty: [Float] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        kolodaView.delegate = self
        kolodaView.dataSource = self
        
        let realm = try! Realm()
        ideas = realm.objects(IdeaData.self).sorted(byKeyPath: "tagNumber", ascending: true).reversed().reversed()
        
        var results: [String] = []

        //いったんタグナンバー順位に整列してタグ100番（センターHoneycomb：中心命題を最初に移動させる
        //センターHoneycombのタグ番号を0番に設定できないために上記の方法をとった
        for idea in ideas {
            let tagNumber = idea.tagNumber as Int
            let sentence = idea.sentence
            var flickOpacity = idea.flickOpacity as Float
            
            flickOpacity = round(flickOpacity * 100) / 100
            
            var star: String = ""
            
            switch flickOpacity {
                case 0 ..< 0.15: star = "✨"
                case 0.15 ..< 0.25: star = "⭐️"
                case 0.25 ..< 0.35: star = "⭐️✨"
                case 0.35 ..< 0.45: star = "⭐️⭐️"
                case 0.45 ..< 0.55: star = "⭐️⭐️✨"
                case 0.55 ..< 0.65: star = "⭐️⭐️⭐️"
                case 0.65 ..< 0.75: star = "⭐️⭐️⭐️✨"
                case 0.75 ..< 0.85: star = "⭐️⭐️⭐️⭐️"
                case 0.85 ..< 0.95: star = "⭐️⭐️⭐️⭐️✨"
                case 0.95 ... 1.05: star = "⭐️⭐️⭐️⭐️⭐️"
                default: star = "⭐️⭐️⭐️⭐️⭐️"
            }
            
            
            if tagNumber == 100 {
                let result = "(0番地):\(star)\n\n\(sentence)"
                results.insert(result, at: 0)
                tmpTagArry.insert(tagNumber, at: 0)
                tmpOpcty.insert(flickOpacity, at: 0)
            } else {
                let result = "(\(tagNumber)番地):\(star)\n\n\(sentence)"
                results.append(result)
                tmpTagArry.append(tagNumber)
                tmpOpcty.append(flickOpacity)
            }
            
        }
        //変数listsを書き換える
        self.lists = results
        
        self.kolodaView.reloadData()
        
//        print("NV80\(lists)")  //透明度の確認用
//        print("NV81:\ntmpTagArry\(tmpTagArry)\ntmpOpcty\(tmpOpcty)")  //透明度の確認用
        
    }
    
    @IBAction func left(_ sender: UIButton) {
        kolodaView.swipe(.left)
        
    }
    
    @IBAction func right(_ sender: UIButton) {
        kolodaView.swipe(.right)
    }
    
    @IBAction func back(_ sender: UIButton) {
        kolodaView.revertAction()
        
        print(kolodaView.countOfCards)
        print(kolodaView.currentCardIndex)
//        print(kolodaViewForCardAtIndex)
        
        //カードを戻したときに透明度の数値を削除する
        if swipeResults.count > 0 {
            swipeResults.removeLast()
        } else {
            print(swipeResults.count)
        }
        print("NV109:カード戻し\(swipeResults)")
    }
    
}

extension NextViewController: KolodaViewDelegate, KolodaViewDataSource {
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {

        let cardView = UITextView()
        cardView.frame = CGRect(x:0, y:0, width:300 , height:400)
        cardView.textAlignment = .natural
        cardView.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: CGFloat(tmpOpcty[index]))
        cardView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 78/255, alpha: 1.0)
        cardView.font = UIFont(name: "HelveticaNeue-medium", size: CGFloat(30))
        
        cardView.text = lists[index]
        
//        print("NV114:\(lists[index])")
//        print("NV115:\(ideas[index].flickOpacity),\(tmpOpcty),\(ideas[index].sentence)")
//        print("NV116行\(ideas[index].sentence)")  //バラバラに表示される
        
        let imageView = UIImageView()
        imageView.addSubview(cardView)
        
        
        return imageView
    }
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return lists.count

    }
    
    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return [.left, .right]
    }
    
    
    // カードを全て消費したときの処理を定義する
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        print("Finish cards.")
//        print("NV152:\(swipeResults)")
        
        let realm = try! Realm()

        var i: Int = 0
        for tmpTag in tmpTagArry {
            let tresult = realm.objects(IdeaData.self).filter("tagNumber == \(tmpTag)").first
            
            try! realm.write {
                tresult?.flickOpacity = round(swipeResults[i] * 100 ) / 100
            }
            i = i + 1
        }
//        print(lists[index])
        
        //シャッフル
//        loadView = loadView.shuffled()
        //リスタート
//        koloda.resetCurrentCardIndex()
    }
    
    //左右どちらに選ばれたかを検出
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        
//        print("140行\(ideas[index].sentence)",direction, nvTagNumber, "透明度\(ideas[index].flickOpacity)")
        
        //flickによる透明度の設定
        var tmpFlickOpacity = round(tmpOpcty[index] * 100) / 100
        let tmpDirection = direction.self
        
        if tmpDirection.rawValue == "right" {
            if tmpFlickOpacity <= 0.9 {
                tmpFlickOpacity = tmpFlickOpacity + 0.1
            } else {
                tmpFlickOpacity = 1.0
            }
//            print("右な",tmpFlickOpacity)
        } else {
            if tmpFlickOpacity >= 0.2 {
                tmpFlickOpacity = tmpFlickOpacity - 0.1
            } else {
                tmpFlickOpacity = 0.1
            }
//            print("左な",tmpFlickOpacity)
        }

            swipeResults.append(round(tmpFlickOpacity * 100) / 100)

        
        print("NV208:swipeResults\(swipeResults)")
//        nvTagNumber = tmpTagArry[index] //一つ次のものが代入される

    }
    
    

    
    
    
}




