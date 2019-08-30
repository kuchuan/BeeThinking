//
//  SettingViewController.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/08/25.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit
import RealmSwift
import SCLAlertView

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = false
    }
    
    
    @IBAction func didTapTextToDeleteDate(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toDeleteData", sender: nil)
    }
    @IBAction func didTapIconToDeleteData(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toDeleteData", sender: nil)
    }
    
    
    @IBAction func didTapTextToDataManagemant(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toDataManegement", sender: nil)
    }
    @IBAction func didTapIconDataManagemnt(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toDataManegement", sender: nil)
    }
    
    
   
    @IBAction func didTextTapToAboutBeeThinking(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toAboutBeeThinking", sender: nil)
    }
    @IBAction func didTapToAboutBeeThinking(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toAboutBeeThinking", sender: nil)
    }
    
    
    @IBAction func didTextTapToAboutBeeSeries(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toAboutBeeSeries", sender: nil)
    }
    @IBAction func didTapToAboutBeeSeries(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toAboutBeeSeries", sender: nil)
    }
    
    
    @IBAction func didTapTextToUserSetting(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toUserSetting", sender: nil)
    }
    @IBAction func didTapToUserSetting(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toUserSetting", sender: nil)
    }
    
    
    @IBAction func didTextTapToAgreement(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toAgreement", sender: nil)
    }
    @IBAction func didTapToAgreement(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toAgreement", sender: nil)
    }
    
    
    
}
