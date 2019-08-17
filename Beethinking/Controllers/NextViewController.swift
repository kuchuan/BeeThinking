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
    
    var swipeResult: String = ""
    var swipeCounter: Int = 0
    var swipePreviosNumber: [Float] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        kolodaView.delegate = self
        kolodaView.dataSource = self
        
        let realm = try! Realm()
        ideas = realm.objects(IdeaData.self).sorted(byKeyPath: "tagNumber", ascending: true).reversed().reversed()
        
        var results: [String] = []

        for idea in ideas {
            let tagNumber = idea.tagNumber as Int
            let sentence = idea.sentence as! String
            let flickOpacity = idea.flickOpacity as Float
            
            var star: String = ""
            
            switch flickOpacity {
                case 0 ..< 0.1: star = "✨"
                case 0.1 ..< 0.2: star = "⭐️"
                case 0.2 ..< 0.3: star = "⭐️✨"
                case 0.3 ..< 0.4: star = "⭐️⭐️"
                case 0.4 ..< 0.5: star = "⭐️⭐️✨"
                case 0.5 ..< 0.6: star = "⭐️⭐️⭐️"
                case 0.6 ..< 0.7: star = "⭐️⭐️⭐️✨"
                case 0.7 ..< 0.8: star = "⭐️⭐️⭐️⭐️"
                case 0.8 ..< 0.9: star = "⭐️⭐️⭐️⭐️✨"
                case 0.9 ..< 1.0: star = "⭐️⭐️⭐️⭐️⭐️"
                default:
                star = "⭐️⭐️⭐️⭐️⭐️"
                
            }
            
            let result = "(\(tagNumber))：\(sentence)\n\(star)"
            
                results.append(result)

        }
        //変数listsを書き換える
        self.lists = results
        
        self.kolodaView.reloadData()
        
        print(lists)
        
        
    }
    
    @IBAction func left(_ sender: UIButton) {
        kolodaView.swipe(.left)
    }
    
    @IBAction func right(_ sender: UIButton) {
        kolodaView.swipe(.right)
    }
    
    @IBAction func back(_ sender: UIButton) {
        kolodaView.revertAction()
    }
    
}

extension NextViewController: KolodaViewDelegate, KolodaViewDataSource {
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {

        let cardView = UITextView()
        cardView.frame = CGRect(x:0, y:0, width:300 , height:400)

        cardView.textAlignment = .natural
        cardView.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        cardView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 78/255, alpha: 1.0)
        cardView.font = UIFont(name: "HelveticaNeue-medium", size: CGFloat(30))
        
        cardView.text = lists[index]
//        cardView.text = ideas.sentence(index)
        
        let imageView = UIImageView()
        imageView.addSubview(cardView)
        
        return imageView
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return lists.count
//        return ideas.count
    }
    
    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return [.left, .right]
    }
    
    func setLetterOpacity(cardIndex: Int, swipeDirection: String, letterOpacity: Float) -> Float {
            return 0.5
    }
    
    
    
}




