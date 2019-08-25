//
//  SettingViewController.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/08/25.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    
    @IBAction func didTextTapToAgreement(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toAgreement", sender: nil)
    }
    @IBAction func didTapToAgreement(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toAgreement", sender: nil)
    }
    
    
    
}
