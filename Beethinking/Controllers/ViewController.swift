//
//  ViewController.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/07/13.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit
import RevealingSplashView


//Honeycombのタグ番号を格納するグローバル変数を作成
var honeycombTagNum: Int = 0



class ViewController: UIViewController, UIScrollViewDelegate {
    
    var honeycombString:String = "00"
    
    var startTransform:CGAffineTransform!
    
    @IBOutlet weak var InputBox: UITextField!
    
    @IBOutlet weak var honeycombView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var honeycombLabel00: UILabel!
    
    

    
//    @IBOutlet weak var honycomButton: HexUIButton!
    
    
    
    
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
        
        
        
        func hexSetting(_ positionx: Float, _ positiony: Float, _ hexOfWidth: Int, _ drawAreaNum: Int, _ i: Int) {
            let hexButton = HexUIButton()
            //サイズ
            hexButton.frame = CGRect(x: CGFloat(positionx), y: CGFloat(positiony),
                                        width: CGFloat(hexOfWidth), height: CGFloat(hexOfWidth))
            //タグ
            hexButton.tag = drawAreaNum * 10 + i
            if hexButton.tag == 0 {
                hexButton.tag = 100
            }
            //ボタンにタイトル挿入
            hexButton.setTitle("\(hexButton.tag)", for: .normal)
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
            
            //6番より大きなタグ番号の蜂の巣ははじめ不可視化して御行く
            if hexButton.tag > 6 && hexButton.tag < 100{
                hexButton.isHidden = true
            }
            //buttonに処理を追加
            // ボタンを押した時に実行するメソッドを指定
            //                hexButton.addTarget(self, action: #selector(hexButtonEvent(_:)), for: UIControlEvents.touchUpInside)
            
            
            honeycombView.addSubview(hexButton)
        }
        
        
        func darwHexButton(originx: Int, originy: Int, hexOfWidth: Int, drawAreaNum: Int) {
            
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
                
                hexSetting(positionx, positiony, hexOfWidth, drawAreaNum, i)
                
                
            }
            
            
            
        }

//----------------------------------------------------------------------
        //蜂の巣の描画（セントラル）
        darwHexButton(originx: 550, originy: 550, hexOfWidth: 140, drawAreaNum: 0)
        
        //蜂の巣の描画（外周periemeter）
        for i in 1...6 {
            var x: Int = 550
            var y: Int = 550
            
            var centerx: Int = 0
            var centery: Int = 0
            
            switch i {
                case 0:
                    centerx = x
                    centery = y
                case 1:
                    centerx = x
                    centery = y - 378
                case 2:
                    centerx = x + 324
                    centery = y - 189
                case 3:
                    centerx = x + 324
                    centery = y + 189
                case 4:
                    centerx = x
                    centery = y + 378
                case 5:
                    centerx = x - 324
                    centery = y + 189
                case 6:
                    centerx = x - 324
                    centery = y - 189
                default:
                    centerx = 0
                    centery = 0
            }
            
            //蜂の巣の描画（外周periemeter）
            darwHexButton(originx: centerx, originy: centery, hexOfWidth: 140, drawAreaNum: i)
            
        }
        
        //蜂の巣フリーエリアの描画（6カ所）
        hexSetting(658, 361, 140, 7, 1)
        hexSetting(766, 550, 140, 7, 2)
        hexSetting(658, 739, 140, 7, 3)
        hexSetting(442, 739, 140, 7, 4)
        hexSetting(334, 550, 140, 7, 5)
        hexSetting(442, 361, 140, 7, 6)
        self.view.viewWithTag(71)?.backgroundColor = UIColor.init(red: 5/255, green: 5/255, blue: 5/255, alpha: 1.0)
//        self.view.viewWithTag(71)?.buttonColor = UIColor.init(red: 5/255, green: 5/255, blue: 5/255, alpha: 1.0)
//        print("ボタンの情報\(self.view.viewWithTag(71)!)")

        //スクロールviewのスクロール設定
        scrollView.contentSize = honeycombView.frame.size
        print("iPhone画面の高さ\(self.view.bounds.height)")
        print("蜂の巣画面の高さは\(scrollView.bounds.height)")
        print("蜂の巣画面のセンター\(self.scrollView.center)")
        print("蜂の巣画面のオリジナルY座標\(self.scrollView.frame.origin.y)")
        //iPhoneの幅に合わせてスクロールビューのオフセットを変える
        scrollView.contentOffset = CGPoint(x: CGFloat(414 + (415 - self.view.bounds.width) / 2 ),
                                           y: CGFloat(680  - (self.view.bounds.height - 220 ) / 2 ))
            
        print(scrollView.contentOffset)
        
        
        scrollView.delegate = self
        
        
    }
    
//----------------------------------------------------------------------
    
    
    @IBAction func didPinchHoneycombView(_ sender: UIPinchGestureRecognizer) {
        
        if(sender.state == UIGestureRecognizer.State.began){
            //ピンチ開始時のアフィン変換をクラス変数に保持する。
            startTransform = honeycombView.transform
            print(honeycombView.transform)
        }
        //ピンチ開始時のアフィン変換を引き継いでアフィン変換を行う。
        honeycombView.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }
    
    
    
    
    @IBAction func didClickToList(_ sender: UIButton) {
        
        let firstIdeas = [
            honeycombLabel00.text,
            honeycombLabel00.text,
            honeycombLabel00.text,
            honeycombLabel00.text,
            honeycombLabel00.text,
            honeycombLabel00.text,
            honeycombLabel00.text
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
        
//        let scrollview = UIScrollView()
//        scrollview.alpha = 0
//
//        let scaleTransform = CGAffineTransform(scaleX: 0.2, y: 0.2)
//
//        let rotationTransform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
//
//        let newTransform = scaleTransform.concatenating(rotationTransform)
//
////        UIScrollView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: scrollview.alpha = CGFloat(1.0), completion: nil)
//
        for i in 1...7  {
            for j in 0...6 {
                if let  button = self.view.viewWithTag( i * 10 + j ) as? UIButton {
                    //不可視属性の指定を解除
                   button.isHidden = false
                }
            }
        }
    }
    
    
    
    @IBAction func didClickGoToHoney(_ sender: UIButton) {
    }
    
    
    @IBAction func inputTextbutton(_ sender: UIButton) {
        
        print(honeycombTagNum)

        if let button = self.view.viewWithTag(honeycombTagNum) as? UIButton {
            print("登録ボタンが押されました")
            print(button.titleLabel?.text as Any)
            button.setTitle(InputBox.text, for: .normal)
            self.view.viewWithTag(2)?.tintColor = UIColor.red
        }


    }
    
   
    
    
}
