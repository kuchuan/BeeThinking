//
//  ViewController.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/07/13.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit
import RevealingSplashView

@IBDesignable

class ViewController: UIViewController {
    
    var honeycombString:String = "00"
    
    @IBOutlet weak var InputBox: UITextField!
    @IBOutlet weak var HoneycombView: UIView!
    @IBOutlet weak var HoneycombLabel00: UILabel!
    @IBOutlet weak var HoneycombLabel01: UILabel!
    @IBOutlet weak var HoneycombLabel02: UILabel!
    @IBOutlet weak var HoneycombLabel03: UILabel!
    @IBOutlet weak var HoneycombLabel04: UILabel!
    @IBOutlet weak var HoneycombLabel05: UILabel!
    @IBOutlet weak var HoneycombLabel06: UILabel!
    
    @IBOutlet weak var HonycomButton: HexUIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize a revealing Splash with with the iconImage, the initial size and the background color
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "splash")!,iconInitialSize: CGSize(width: 400, height: 400), backgroundColor: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha:1.0))
        
        revealingSplashView.animationType = .popAndZoomOut
        revealingSplashView.delay = 1.0
        
        //Adds the revealing splash view as a sub view
        self.view.addSubview(revealingSplashView)
        
        //Starts animation
        revealingSplashView.startAnimation(){
//            print("Complerted")
        }
        
        
        
        func DarwHexButton(originx: Int, originy: Int, hexOfWidth: Int) {
            
            var positionx: Float = 0.0
            var positiony: Float = 0.0
            
            for i in 0...6 {
                //原点からポジションの割り出し
                switch i {
                    case 0:
                        positionx = Float(originx)
                        positiony = Float(originy)
                    case 1:
                        positionx = Float(originx)
                        positiony = Float(originy - (126 * hexOfWidth / 140))
                    case 2:
                        positionx = Float(originx + (108 * hexOfWidth / 140))
                        positiony = Float(originy - (63 * hexOfWidth / 140))
                    case 3:
                        positionx = Float(originx + (108 * hexOfWidth / 140))
                        positiony = Float(originy + (63 * hexOfWidth / 140))
                    case 4:
                        positionx = Float(originx)
                        positiony = Float(originy + (126 * hexOfWidth / 140))
                    case 5:
                        positionx = Float(originx - (108 * hexOfWidth / 140))
                        positiony = Float(originy + (63 * hexOfWidth / 140))
                    case 6:
                        positionx = Float(originx - (108 * hexOfWidth / 140))
                        positiony = Float(originy - (63 * hexOfWidth / 140))
                    default:
                        positionx = Float(originx)
                        positiony = Float(originy)
                }
                
                let hexButton = HexUIButton()
                //サイズ
                hexButton.frame = CGRect(x: CGFloat(positionx), y: CGFloat(positiony), width: CGFloat(hexOfWidth), height: CGFloat(hexOfWidth))
                //タグ
                hexButton.tag = i
                //ボタンにタイトル挿入
                hexButton.setTitle("hexButvuuuuuooovttoooooooooogivvvvovoooooooooooton\(i)", for: .normal)
                hexButton.setTitleColor(.white, for: .normal)
                hexButton.layer.borderWidth = 1
                
                //6角形の値を入力
                hexButton.numberOfCorner = 6
                //6角形の傾き
                hexButton.rotation = 30
                
                //枠内のpadding
                hexButton.titleEdgeInsets = UIEdgeInsets(top: 25.0, left: 25.0, bottom: 25.0, right: 25.0)
                
                //枠内の行数
                hexButton.titleLabel?.numberOfLines = 5
                
                //ボタンだけどラベルのように扱いたいので
                 hexButton.isEnabled = false
                //buttonに処理を追加
                // ボタンを押した時に実行するメソッドを指定
//                hexButton.addTarget(self, action: #selector(hexButtonEvent(_:)), for: UIControlEvents.touchUpInside)

                
                
                HoneycombView.addSubview(hexButton)
                
            }
        }
        
        //蜂の巣の描画（セントラル）
        DarwHexButton(originx: 200, originy: 300, hexOfWidth: 140)
        
        
        
        
        
//        // 画面サイズを初期値として `MainView` クラスを `mainView` としてインスタンス化します。
//        let mainView = HexView(frame: self.view.bounds)
//
//        // `MainView` に自動サイズ調整用に `autoresizingMask` を設定
//        mainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//        // `mainView` オブジェクトを表示します。
//        self.view.addSubview(mainView)
        
        
        
        
        
//        HonycomButton.titleLabel?.numberOfLines = 6
//        HonycomButton.setTitle("タイトルの文字列です。すごく長いので改行して欲しいのですよ。", for: .normal)
    

        
    }
    
    @IBAction func didClickToList(_ sender: UIButton) {
        
        let firstIdeas = [
            HoneycombLabel00.text,
            HoneycombLabel01.text,
            HoneycombLabel02.text,
            HoneycombLabel03.text,
            HoneycombLabel04.text,
            HoneycombLabel05.text,
            HoneycombLabel06.text
        ]
        performSegue(withIdentifier: "toList", sender: firstIdeas)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toList" {
            let nextVC = segue.destination as! SCViewController
            nextVC.ideas = sender as! [String]
        }
    }
    
    @IBAction func didClickToMakeHoneycomb(_ sender: UIButton) {
    }
    
    
    
    @IBAction func didClickGoToHoney(_ sender: UIButton) {
    }
    
    
    @IBAction func InputTextbutton(_ sender: UIButton) {
        choseLavel(str: honeycombString, text: InputBox.text ?? "")
    }
    
    @IBAction func ChangeLabelSize00(_ sender: UISlider) {
        let sliderNum = sender.value
        let sizeOfLabel = 120 + CGFloat(sliderNum * 120)
        let sizeOfLabelFont = 16 + CGFloat(Int(sliderNum * 15))
        let offsetOfLabel = CGFloat(Int((120 - sizeOfLabel) / 2))
        
        HoneycombLabel04.text = "\(sliderNum)"
        
        //
        //文字の大きさをスライダーで変える
        HoneycombLabel00.font = HoneycombLabel00.font.withSize(sizeOfLabelFont)
        //ラベルボックスの大きさを変える
        HoneycombLabel00.frame = CGRect(x:147 + offsetOfLabel, y:162 + offsetOfLabel, width:sizeOfLabel, height:sizeOfLabel )

        //文字の大きさをスライダーで変える
        HoneycombLabel01.font = HoneycombLabel00.font.withSize(sizeOfLabelFont)
        //ラベルボックスの大きさを変える
        HoneycombLabel01.frame = CGRect(x:147 + offsetOfLabel, y:40 + offsetOfLabel * 3, width:sizeOfLabel, height:sizeOfLabel )
        
        //文字の大きさをスライダーで変える
        HoneycombLabel04.font = HoneycombLabel00.font.withSize(sizeOfLabelFont)
        //ラベルボックスの大きさを変える
        HoneycombLabel04.frame = CGRect(x:147 + offsetOfLabel, y:284 - offsetOfLabel, width:sizeOfLabel, height:sizeOfLabel )
        
        //文字の大きさをスライダーで変える
        HoneycombLabel02.font = HoneycombLabel00.font.withSize(sizeOfLabelFont)
        //ラベルボックスの大きさを変える
        HoneycombLabel02.frame = CGRect(x:269 - offsetOfLabel, y:106 + offsetOfLabel * 2, width:sizeOfLabel, height:sizeOfLabel )
        
        //文字の大きさをスライダーで変える
        HoneycombLabel03.font = HoneycombLabel00.font.withSize(sizeOfLabelFont)
        //ラベルボックスの大きさを変える
        HoneycombLabel03.frame = CGRect(x:269 - offsetOfLabel, y:228, width:sizeOfLabel, height:sizeOfLabel )
        
        //文字の大きさをスライダーで変える
        HoneycombLabel05.font = HoneycombLabel00.font.withSize(sizeOfLabelFont)
        //ラベルボックスの大きさを変える
        HoneycombLabel05.frame = CGRect(x:25 + offsetOfLabel * 3, y:229, width:sizeOfLabel, height:sizeOfLabel )
        
        //文字の大きさをスライダーで変える
        HoneycombLabel06.font = HoneycombLabel00.font.withSize(sizeOfLabelFont)
        //ラベルボックスの大きさを変える
        HoneycombLabel06.frame = CGRect(x:25 + offsetOfLabel * 3, y:107 + offsetOfLabel * 2, width:sizeOfLabel, height:sizeOfLabel )

    }
    
    @IBAction func touchLabel00(_ sender: UITapGestureRecognizer) {
        
        resetBorderColor()
//        HoneycombLabel00.frame = CGRect(x:147 + offsetOfLabel, y:162 + offsetOfLabel, width:sizeOfLabel, height:sizeOfLabel )
        //　ラベル枠の枠線太さと色
        HoneycombLabel00.layer.borderColor = UIColor.red.cgColor
        HoneycombLabel00.layer.borderWidth = 3
        honeycombString = "00"
        InputBox.text = HoneycombLabel00.text
        
        // ラベル枠を丸くする
//        HoneycombLabel00.layer.masksToBounds = true
        // ラベル丸枠の半径
//        HoneycombLabel00.layer.cornerRadius = 10
        
//        self.view.addSubview(HoneycombLabel00)
    }
    
    @IBAction func touchLabel01(_ sender: UITapGestureRecognizer) {
        
        resetBorderColor()
        //　ラベル枠の枠線太さと色
        HoneycombLabel01.layer.borderColor = UIColor.blue.cgColor
        HoneycombLabel01.layer.borderWidth = 3
        honeycombString = "01"
        InputBox.text = HoneycombLabel01.text

    }
    
    @IBAction func touchLabel02(_ sender: UITapGestureRecognizer) {
    
        resetBorderColor()
        //　ラベル枠の枠線太さと色
        HoneycombLabel02.layer.borderColor = UIColor.blue.cgColor
        HoneycombLabel02.layer.borderWidth = 3
        honeycombString = "02"
        InputBox.text = HoneycombLabel02.text
    
    }

    @IBAction func touchLabel03(_ sender: UITapGestureRecognizer) {
        
        resetBorderColor()
        //　ラベル枠の枠線太さと色
        HoneycombLabel03.layer.borderColor = UIColor.blue.cgColor
        HoneycombLabel03.layer.borderWidth = 3
        honeycombString = "03"
        InputBox.text = HoneycombLabel03.text
        
    }
    
    
    @IBAction func touchLabel04(_ sender: UITapGestureRecognizer) {
        
        resetBorderColor()
        //　ラベル枠の枠線太さと色
        HoneycombLabel04.layer.borderColor = UIColor.blue.cgColor
        HoneycombLabel04.layer.borderWidth = 3
        honeycombString = "04"
        InputBox.text = HoneycombLabel04.text
    }
    
    @IBAction func touchLabel05(_ sender: UITapGestureRecognizer) {
        
        resetBorderColor()
        //　ラベル枠の枠線太さと色
        HoneycombLabel05.layer.borderColor = UIColor.blue.cgColor
        HoneycombLabel05.layer.borderWidth = 3
        honeycombString = "05"
        InputBox.text = HoneycombLabel05.text
    }
    
    @IBAction func touchLabel06(_ sender: UITapGestureRecognizer) {
        
        resetBorderColor()
        //　ラベル枠の枠線太さと色
        HoneycombLabel06.layer.borderColor = UIColor.blue.cgColor
        HoneycombLabel06.layer.borderWidth = 3
        honeycombString = "06"
        InputBox.text = HoneycombLabel06.text
    }
    
    
    func resetBorderColor(){
        //　ラベル枠の枠線太さと色
        HoneycombLabel00.layer.borderColor = UIColor.clear.cgColor
        HoneycombLabel01.layer.borderColor = UIColor.clear.cgColor
        HoneycombLabel02.layer.borderColor = UIColor.clear.cgColor
        HoneycombLabel03.layer.borderColor = UIColor.clear.cgColor
        HoneycombLabel04.layer.borderColor = UIColor.clear.cgColor
        HoneycombLabel05.layer.borderColor = UIColor.clear.cgColor
        HoneycombLabel06.layer.borderColor = UIColor.clear.cgColor
        //ついでに入力欄の消去もする
        InputBox.text = ""
    }

    func choseLavel(str:String, text:String){
        
        switch str {
            case "00":
                HoneycombLabel00.text = text
            case "01":
                HoneycombLabel01.text = text
            case "02":
                HoneycombLabel02.text = text
            case "03":
                HoneycombLabel03.text = text
            case "04":
                HoneycombLabel04.text = text
            case "05":
                HoneycombLabel05.text = text
            case "06":
                HoneycombLabel06.text = text
        default :
            HoneycombLabel00.text = text
        }
        
    }
    
}

