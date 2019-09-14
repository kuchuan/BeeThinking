//
//  SCViewController.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/08/03.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit
import RealmSwift




class SCViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var ideas:[IdeaData] = []
    
    
    fileprivate func reloadTableView() {
        //Realmに接続
        let realm = try! Realm()
        
        ideas = realm.objects(IdeaData.self).filter("attributeId == \(generalAttributeId) AND tagNumber >= 0 AND tagNumber <= 99").sorted(byKeyPath: "tagNumber", ascending: false).reversed()
        ideas.insert(realm.objects(IdeaData.self).filter("tagNumber == 100  AND attributeId == \(generalAttributeId)").first!, at: 0)
        
        //        print("SCV\(#line):\(ideas)")
        //画面の更新
        tableView.reloadData()
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.hidesBackButton = false
        
    }

    
    //画面が表示されるたびに実行
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
    }
    

    @IBAction func didClickToFlickView(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toFlickView", sender: nil)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toFlickView" {
//            let nextVC = segue.destination as! NextViewController
//            nextVC.lists = sender as! [String]
//        }
//    }

}



extension SCViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ideas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //セクションの記述
//        let sectitonDate = table
        
        let result = ideas[indexPath.row]
        
        
        if (result.tagNumber == 100) || (result.tagNumber % 10 == 0) {
            cell.backgroundColor = UIColor.init(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        var cellAddText: String = ""
        var cellSpace: String = ""
        
        switch result.tagNumber {
        case 100:
            cellSpace = ""
            cellAddText = "▼中心課題"
        case 0...6:
            cellSpace = "　"
            cellAddText = "　　►周辺課題"
        case 10:
            cellSpace = ""
            cellAddText = "▼周辺課題"
        case 20:
            cellSpace = ""
            cellAddText = "▼周辺課題"
        case 30:
            cellSpace = ""
            cellAddText = "▼周辺課題"
        case 40:
            cellSpace = ""
            cellAddText = "▼周辺課題"
        case 50:
            cellSpace = ""
            cellAddText = "▼周辺課題"
        case 60:
            cellSpace = ""
            cellAddText = "▼周辺課題"
        default:
            cellSpace = "　"
            cellAddText = "　　►アイデア"
        }
        
        
        cell.textLabel?.text = cellSpace + result.sentence
        cell.detailTextLabel?.text = cellAddText + countStar(number: result.flickOpacity)
        
        //矢印で削除
        if result.tagNumber != 100 {
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        //Realmから対象のデータを削除
        let result = ideas[indexPath.row]
        
        if result.tagNumber != 100 {
            
            let realm = try! Realm()
            try! realm.write {
                realm.delete(result)
            }
            //配列ideasから対象のideaを削除
            ideas.remove(at: indexPath.row)
            //画面から対象のideaを削除
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    
    func countStar(number: Float) -> String{
        
        //        var number: Float
        var star: String
        
        switch number {
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
        return star
    }
    
}

