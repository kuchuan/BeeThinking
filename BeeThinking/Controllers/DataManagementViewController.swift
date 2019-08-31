//
//  FileManagementViewController.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/08/29.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit
import RealmSwift

class DataManagementViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var ideas:[IdeaData] = []
    
    var tmpGeneralAttributeId: Int = 0
    
    
    fileprivate func reloadTableView() {
        //Realmに接続
        let realm = try! Realm()
        
        ideas = realm.objects(IdeaData.self).filter("tagNumber == 100").sorted(byKeyPath: "date", ascending: false).reversed()
        //print("SCV\(#line):\(ideas)")
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
    
    @IBAction func didTapLoardbutton(_ sender: UITapGestureRecognizer) {
        
        generalAttributeId = tmpGeneralAttributeId
        dataResetToggleFromDateManagement = true
        
        performSegue(withIdentifier: "fromDateManagemntToMain", sender: nil)
    }
    
    
    
    
}


    


extension DataManagementViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ideas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataNameCell", for: indexPath)
        
        // selectionStyleを使用しないので、UITableViewCellSelectionStyleNoneを設定。
//        cell.selectionStyle = UITableViewCell.SelectionStyle
//        let selectedView = UIView()
//        selectedView.backgroundColor = UIColor.red
//        cell.selectedBackgroundView = selectedView
        
        
        let result = ideas[indexPath.row]
        
        //日付の書式の変更
        let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "YYYY/MM/dd"
        
        let dateString = dateFormatter.string(from: result.date)
        
        cell.textLabel?.text = result.sentence
        cell.detailTextLabel?.text = dateString
        //矢印で削除
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    //矢印付きののセルがクリックされたときの処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //クリックされたTodoを取得する
        let number = ideas[indexPath.row]
//        print(number.attributeId)
        
        tmpGeneralAttributeId = number.attributeId
        
print("DataMnge",#line,"Gen:tmpGen",generalAttributeId,tmpGeneralAttributeId)
        
//        performSegue(withIdentifier: "fromDateManagemntToMain", sender: number)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        //Realmから対象のデータを削除
        let result = ideas[indexPath.row]
        
        let number = result.attributeId

//        generalAttributeId = result.attributeId
        
        let realm = try! Realm()
        
        let idea = realm.objects(IdeaData.self).filter("attributeId == \(number)")
        try! realm.write {
            realm.delete(idea)
        }
        //配列ideasから対象のideaを削除
        ideas.remove(at: indexPath.row)
        //画面から対象のideaを削除
        tableView.deleteRows(at: [indexPath], with: .fade)
        
    }
    

}
