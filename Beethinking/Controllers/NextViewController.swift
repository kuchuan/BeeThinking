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
import SCLAlertView



class NextViewController: UIViewController {
    
    
    @IBOutlet weak var kolodaView: KolodaView!
    
    @IBOutlet weak var viewCountStar: UILabel!
    
    
    var ideas: [IdeaData] = []
    var lists: [String] = []
    var swipeResults: [Float] = []
    
    var nvTagNumber: Int = 0
    var tmpSlideOpacity: Float = 0.0
    
    var tmpTagArry: [Int] = []
    var tmpOpcty: [Float] = []
    
    
    fileprivate func settingDate(tmpSlideOpacity: Float) {
        
        //
        let realm = try! Realm()
        
        //1.05以上は「中心課題と周辺課題」を選択し、それ以外は透過度で選択する
        if tmpSlideOpacity > 1.05 {
            ideas = realm.objects(IdeaData.self).filter("attributeId == \(generalAttributeId) AND tagNumber >= 0 AND tagNumber <= 6").sorted(byKeyPath: "tagNumber", ascending: false).reversed()
        } else {
            ideas = realm.objects(IdeaData.self).filter("attributeId == \(generalAttributeId) AND tagNumber >= 0 AND tagNumber <= 99").filter("flickOpacity >= \(tmpSlideOpacity)").sorted(byKeyPath: "tagNumber", ascending: false).reversed()
        }

        ideas.insert(realm.objects(IdeaData.self).filter("tagNumber == 100  AND attributeId == \(generalAttributeId)").first!, at: 0)
        
        var results: [String] = []
        
        //いったんタグナンバー順位に整列してタグ100番（センターHoneycomb：中心課題を最初に移動させる
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
            case 0.95 ..< 1.05: star = "⭐️⭐️⭐️⭐️⭐️"
            default: star = "⭐️⭐️⭐️⭐️⭐️"
            }
            
            
            if tagNumber == 100 {
                let result = "[中心課題]:\n\(star)\n\n\(sentence)"
                results.insert(result, at: 0)
                tmpTagArry.insert(tagNumber, at: 0)
                tmpOpcty.insert(flickOpacity, at: 0)
            } else {
                let result = "[\(tagNumber)番地]:\n\(star)\n\n\(sentence)"
                results.append(result)
                tmpTagArry.append(tagNumber)
                tmpOpcty.append(flickOpacity)
            }
//            print("\(#line)あやしい関数周りにトラップ\(tmpTagArry.count)")
        }
        //変数listsを書き換える
        self.lists = results
    }

    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        kolodaView.delegate = self
        kolodaView.dataSource = self
        
        settingDate(tmpSlideOpacity: 0.0)
        
        self.kolodaView.reloadData()
        
//        print("\(#line)\(lists)")  //透明度の確認用
//        print("\(#line):\ntmpTagArry\(tmpTagArry)\ntmpOpcty\(tmpOpcty)")  //透明度の確認用
        
    }
    
    @IBAction func left(_ sender: UIButton) {
        kolodaView.swipe(.left)
        
    }
    
    @IBAction func right(_ sender: UIButton) {
        kolodaView.swipe(.right)
    }
    
    @IBAction func back(_ sender: UIButton) {
        kolodaView.revertAction()
        
//        print("\(#line):スワイプ結果\(swipeResults)")
//        print("\(#line):カード\(kolodaView.currentCardIndex)/\(kolodaView.countOfCards)")
        
    }
    
    @IBAction func starsSider(_ sender: UISlider) {

        let starString = countStar(number: sender.value)
        tmpSlideOpacity = round(sender.value * 10 ) / 10
//        print("\(#line)flickOpacity値：\(tmpSlideOpacity),sender値：\(sender.value)")
        viewCountStar.text = starString
    }
    
    
    @IBAction func didClickAgein(_ sender: HexUIButton) {
        tmpTagArry = []
        tmpOpcty = []
//        print("\(#line)nvTagNumber：\(nvTagNumber)")
        settingDate(tmpSlideOpacity: tmpSlideOpacity)
        kolodaView.resetCurrentCardIndex()
    }
    
    @IBAction func didClickSetFiveStar(_ sender: HexUIButton) {
        
        let alertView = SCLAlertView()
        alertView.addButton("はい") {
            self.tmpTagArry = []
            self.tmpOpcty = []
            self.settingDateFiveStar(tmpSlideOpacity: self.tmpSlideOpacity)
            self.kolodaView.resetCurrentCardIndex()
            
        }
        alertView.showInfo(
            "選択したアイデアの\n評価レートを\n⭐️⭐️⭐️⭐️⭐️に\n変更します", // タイトル
            subTitle: "よろしいですか", // サブタイトル
            closeButtonTitle: "いいえ", // クローズボタンのタイトル
            //                timeout: 2 , // **秒ごに、自動的に閉じる（OKでも閉じることはできる）
            colorStyle:  0xFFCF2F, // ボタン、シンボルの色
            colorTextButton: 0x000000, // ボタンの文字列の色
            //            circleIconImage: UIImage?, //アイコンimage
            animationStyle:.bottomToTop // スタイル（Success)指定
        )
    }
    
    @IBAction func didClickShareMenu(_ sender: HexUIButton) {
        
//        let text = "何かデフォルトで欄に入っててほしい文字列"
//        let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        if let encodedText = encodedText,
//            let url = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        }
 
        //1．シェアするデータの配列を作成
        let date = ["Now I'm learning iOS. This is example post"] as [Any]
        //2．シェア画面作成

        //activityItems:シェアしたいデータを設定
        let controller = UIActivityViewController(activityItems: date, applicationActivities: nil)

        //3．シェア画面を表示
        present(controller, animated: true, completion: nil)
            //
            //
        
    }
    
    fileprivate func settingDateFiveStar(tmpSlideOpacity: Float) {
        
        //選択されたデータを5スターに変更する
        let realm = try! Realm()
        
        //1.05以上は「中心課題と周辺課題」を選択し、それ以外は透過度で選択する
        if tmpSlideOpacity > 1.05 {
            ideas = realm.objects(IdeaData.self).filter("attributeId == \(generalAttributeId) AND tagNumber >= 0 AND tagNumber <= 6").sorted(byKeyPath: "tagNumber", ascending: false).reversed()
        } else {
            ideas = realm.objects(IdeaData.self).filter("attributeId == \(generalAttributeId) AND tagNumber >= 0 AND tagNumber <= 99").filter("flickOpacity >= \(tmpSlideOpacity)").sorted(byKeyPath: "tagNumber", ascending: false).reversed()
        }
        
        ideas.insert(realm.objects(IdeaData.self).filter("tagNumber == 100  AND attributeId == \(generalAttributeId)").first!, at: 0)
        
        var results: [String] = []
        
        //いったんタグナンバー順位に整列してタグ100番（センターHoneycomb：中心課題を最初に移動させる
        for idea in ideas {
            let tagNumber = idea.tagNumber as Int
            let sentence = idea.sentence
            var flickOpacity = idea.flickOpacity as Float
            
            flickOpacity = 1.0
            
            try! realm.write {
                idea.flickOpacity = 1.0
            }
            
            let star: String = "⭐️⭐️⭐️⭐️⭐️"
            
            
            if tagNumber == 100 {
                let result = "[中心課題]:\n\(star)\n\n\(sentence)"
                results.insert(result, at: 0)
                tmpTagArry.insert(tagNumber, at: 0)
                tmpOpcty.insert(flickOpacity, at: 0)
            } else {
                let result = "[\(tagNumber)番地]:\n\(star)\n\n\(sentence)"
                results.append(result)
                tmpTagArry.append(tagNumber)
                tmpOpcty.append(flickOpacity)
            }
            
        }
        //変数listsを書き換える
        self.lists = results
    }
    
    
    
    
    func countStar(number: Float) -> String{
        
//        var number: Float
        var star: String
        
        switch number {
        case 0: star = "すべてを選択する"
        case 0 ..< 0.15: star = "✨"
        case 0.15 ..< 0.25: star = "⭐️"
        case 0.25 ..< 0.35: star = "⭐️✨"
        case 0.35 ..< 0.45: star = "⭐️⭐️"
        case 0.45 ..< 0.55: star = "⭐️⭐️✨"
        case 0.55 ..< 0.65: star = "⭐️⭐️⭐️"
        case 0.65 ..< 0.75: star = "⭐️⭐️⭐️✨"
        case 0.75 ..< 0.85: star = "⭐️⭐️⭐️⭐️"
        case 0.85 ..< 0.95: star = "⭐️⭐️⭐️⭐️✨"
        case 0.95 ..< 1.05: star = "⭐️⭐️⭐️⭐️⭐️"
        case 1.05: star = "中心課題と周辺課題のみ"
        default: star = "すべてを選択する"
        }
        return star
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
        print("\(#line):Finish cards.\(tmpTagArry.count)")
        
        let realm = try! Realm()

        var i: Int = 0
        for tmpTag in tmpTagArry {
            let result = realm.objects(IdeaData.self).filter("attributeId == \(generalAttributeId)  AND tagNumber == \(tmpTag)").first
            
            try! realm.write {
                result?.flickOpacity = round(swipeResults[i] * 100 ) / 100
            }
            i = i + 1
        }
        //シャッフル
//        loadView = loadView.shuffled()
        //リスタート
//        koloda.resetCurrentCardIndex()
    }
    
    //左右どちらに選ばれたかを検出
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        
        //カードとIndexが一致しているか確認（revertActionを高速で行うと処理の取りこぼしが出るため）
        let difference = swipeResults.count - index
        
        if difference > 0 {
            for _ in 1 ... difference {
                swipeResults.removeLast()
            }
        }

        
        //flickによる透明度の設定
        var tmpFlickOpacity = round(tmpOpcty[index] * 100) / 100
        let tmpDirection = direction.self
        
        if tmpDirection.rawValue == "right" {
            if tmpFlickOpacity <= 0.9 {
                tmpFlickOpacity = tmpFlickOpacity + 0.1
            } else {
                tmpFlickOpacity = 1.0
            }

        } else {
            if tmpFlickOpacity >= 0.2 {
                tmpFlickOpacity = tmpFlickOpacity - 0.1
            } else {
                tmpFlickOpacity = 0.1
            }

        }

            swipeResults.append(round(tmpFlickOpacity * 100) / 100)

        
//        print("\(#line):\(swipeResults)")
//        print("\(#line):現在のカード\(kolodaView.currentCardIndex)/\(kolodaView.countOfCards) & スワイプインデックス:\(index)")
//        print("\n")
//        nvTagNumber = tmpTagArry[index] //一つ次のものが代入される

    }
    

    
}

//デバッグ用
//    func print(debug: Any = "",
//               function: String = #function,
//               file: String = #file,
//               line: Int = #line) {
//        var filename = file
//        if let match = filename.range(of: "[^/]*$", options: .regularExpression) {
//            filename = filename.substring(with: match)
//        }
//        Swift.print("Log:\(filename):L\(line):\(function) \(debug)")
//    }



