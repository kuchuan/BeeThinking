//
//  NextViewController.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/07/28.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit
import Koloda

class NextViewController: UIViewController {
    
    
    @IBOutlet weak var kolodaView: KolodaView!
    
    var lists: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        kolodaView.delegate = self
        kolodaView.dataSource = self
        
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

        let textView = UITextView()
        textView.frame = CGRect(x:0, y:0, width:300 , height:400)

        textView.textAlignment = .natural
        textView.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        textView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 200/255, alpha: 1.0)
        textView.font = UIFont(name: "HelveticaNeue-medium", size: CGFloat(30))
        
        textView.text = lists[index]
        
        let imageView = UIImageView()
        imageView.addSubview(textView)
        
        return imageView
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return lists.count
    }
    
    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return [.left, .right]
    }
    
    
    
    
}


