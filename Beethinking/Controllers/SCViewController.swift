//
//  SCViewController.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/08/03.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit

class SCViewController: UIViewController {
    
    var ideas: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    

    @IBAction func didClickToFlickView(_ sender: UIButton) {
        performSegue(withIdentifier: "toFlickView", sender: ideas)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFlickView" {
            let nextVC = segue.destination as! NextViewController
            nextVC.lists = sender as! [String]
        }
    }

}

extension SCViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ideas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        cell.textLabel?.text = ideas[indexPath.row]
        
        return cell
    }
    
    
}
