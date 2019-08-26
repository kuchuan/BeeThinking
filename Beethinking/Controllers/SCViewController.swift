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
    
        ideas = realm.objects(IdeaData.self).filter("tagNumber >= 0 AND tagNumber <= 99").filter("AttributeId == 'generalAttributeId'").sorted(byKeyPath: "tagNumber", ascending: false).reversed()
        ideas.insert(realm.objects(IdeaData.self).filter("tagNumber == 100  AND AttributeId == 'generalAttributeId'").first!, at: 0)

//        print("SCV\(#line):\(ideas)")
        
        //画面の更新
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        
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
        
        let idea = ideas[indexPath.row]
        
        
        cell.textLabel?.text = idea.sentence
        
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //Realmから対象のデータを削除
        let idea = ideas[indexPath.row]
        let realm = try! Realm()
        try! realm.write {
            realm.delete(idea)
        }
        //配列ideasから対象のideaを削除
        ideas.remove(at: indexPath.row)
        //画面から対象のideaを削除
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        
        
    }
    
    
}
