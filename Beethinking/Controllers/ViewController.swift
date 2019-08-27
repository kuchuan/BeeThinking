//
//  ViewController.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/07/13.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit
import RevealingSplashView
import RealmSwift
import AVFoundation
import SCLAlertView



//Honeycombのタグ番号を格納するグローバル変数を作成
var honeycombTagNum: Int = 100
var honeycombPreviousTagNum: Int = 100
//同じ中心課題のグループをidで管理
var generalAttributeId: Int = 0

//中央課題と周辺課題のお互いを同時に書き込めるがどうか（初期値はする:true）
var autoSetOfDuplicate: Bool = true
//データが別の画面でリセットされたかどうかの判定を行う（予約）
var dataResetToggle: Bool = false

//var deleatIdea: Int = 100 {
//    willSet {
//        print("監視中")
//    }
//    didSet {
//        print("監視中")
//    }
//}




class ViewController: UIViewController, UIScrollViewDelegate, AVAudioPlayerDelegate {
    
    //カセットデッキ的なやつ
    var player: AVAudioPlayer!
    
    //Zoomの現在倍率を格納する変数
    var startTransform:CGAffineTransform!
    
    @IBOutlet weak var inputBox: UITextField!
    
    @IBOutlet weak var honeycombView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var bottle: UIButton!
    
    var ideas:[IdeaData] = []

    
    //画面が表示されるたびに実行
    override func viewWillAppear(_ animated: Bool) {
//        print("\(#line)リロード")
        reloadHoneycombView()
    }

    
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
        
//---------------------------------------------------------
        //再生する音楽ファイルのパス作成
        let audioPath = Bundle.main.path(forResource: "BeeThinking", ofType: "mp3")!
        
        //URLにする必要があるので･･･
        let audioUrl = URL(fileURLWithPath: audioPath)
        
        //音楽ファイルを元に、プレイユアー作成
        //以下だとエラーが出る。Do catchで作ると
        do {
            player = try AVAudioPlayer(contentsOf: audioUrl)
            
            //無限ループ
            player.numberOfLoops = -1 //ループ再生
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        //再生
        player.delegate = self //おまじない
        player.prepareToPlay() //再生の準備
        
        
//---------------------------------------------------------
        // タップジェスチャーを作成します。
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(singleTap(_:)))
        
        // シングルタップで反応するように設定します。
        singleTapGesture.numberOfTapsRequired = 1
        
        
        // ビューにジェスチャーを設定します。
        view.addGestureRecognizer(singleTapGesture)
        

//---------------------------------------------------------
//Honeycom描画
        
        //セッティング
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
            hexButton.setTitle("", for: .normal)
            hexButton.setTitleColor(.black, for: .normal)
            hexButton.layer.borderWidth = 0
            
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
            
            //6番より大きなタグ番号の蜂の巣はあらかじめ不可視化しておく
            if hexButton.tag > 6 && hexButton.tag < 100{
                hexButton.isHidden = true
            }
            //buttonに処理を追加・・・ができなかったので、画面タップに反応することにした
            
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
        darwHexButton(originx: 950, originy: 950, hexOfWidth: 140, drawAreaNum: 0)
        
        //蜂の巣の描画（外周periemeter）
        for i in 1...6 {
            let x: Int = 950
            let y: Int = 950
            
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
        hexSetting(1058, 761, 140, 7, 1)
        hexSetting(1166, 950, 140, 7, 2)
        hexSetting(1058, 1139, 140, 7, 3)
        hexSetting(842, 1139, 140, 7, 4)
        hexSetting(734, 950, 140, 7, 5)
        hexSetting(842, 761, 140, 7, 6)

        //スクロールviewのスクロール設定
        scrollView.contentSize = honeycombView.frame.size
//        //画面作成時の確認用
//        print("iPhone画面の高さ\(self.view.bounds.height)")
//        print("蜂の巣画面の高さは\(scrollView.bounds.height)")
//        print("蜂の巣画面のセンター\(self.scrollView.center)")
//        print("蜂の巣画面のオリジナルY座標\(self.scrollView.frame.origin.y)")
        //iPhoneの幅に合わせてスクロールビューのオフセットを変える
        scrollView.contentOffset = CGPoint(x: CGFloat(814 + (415 - self.view.bounds.width) / 2 ),
                                           y: CGFloat(1080  - (self.view.bounds.height - 220 ) / 2 ))


//        //画面作成時の確認用
//        print("\(#line),\(scrollView.contentOffset)")
        
        scrollView.delegate = self
        
//        reloadHoneycombView()
        
        
        //Realmの情報管理用
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        
    }

    
    
//----------------------------------------------------------------------
//----------------------------------------------------------------------

    //初期データ読み込み
    
    //画面の更新
    fileprivate func reloadHoneycombView() {
        //Realmに接続
        let realm = try! Realm()

        //直近の一覧を取得する(reversedは)
        ideas = realm.objects(IdeaData.self).reversed()
        //最も大きなattributeIdを取得してループですべてのtagNumberに当たって蜂の巣を埋めていく
        let attributeNum = realm.objects(IdeaData.self).max(ofProperty: "attributeId") as Int?
        
        if attributeNum == nil {
            generalAttributeId = 1
        } else {
            generalAttributeId = attributeNum!
        }
            //ループ
            var num: Int = 0
            for i in 0...7 {
                for j in 0...6 {
                    num = i * 10 + j
                    if num == 0 {
                        num = 100
                    }
                    
                    let result = realm.objects(IdeaData.self).filter("attributeId == \(generalAttributeId) AND tagNumber == \(num)")
                    
                    //ボタンが作られているかどうかの判定
                    if let button = self.view.viewWithTag( num ) as? HexUIButton {
                        button.setTitle(result.first?.sentence, for: UIControl.State.normal)
//                        print("\(#line):蜂の巣\(num)\(String(describing: button.currentTitle)) & \(String(describing: result.first?.sentence))")
                    } else {
                        //存在しない蜂の巣の番号を踏んだときに発動
                        print("vc\(#line):\(num)はnil")
                    }
                }
            }
        setHoneycombColor()
    }
    
    
    //realm周り
    
    //realmへのアイデアデータ新規登録
    fileprivate func createNewIdea(_ text: String, _ tag: Int) {
        
        let setIdea = CreateIdea()
        let res = setIdea.createIdea(text: text, tag: tag, autoSpredSwich: autoSetOfDuplicate)
        print ("\(#line)createIdea",res)

    }

    //realmへのアイデアデータのアップデート
    fileprivate func updateOldIdea(_ text: String, _ tag: Int) {
        
        let setIdea = UpdateIdea()
        let res = setIdea.updateIdea(text: text, tag: tag, autoSpredSwich: autoSetOfDuplicate)
        print ("\(#line)updateIdea",res)
        
    }

  
    
//----------------------------------------------------------------------
    
    @IBAction func didPinchHoneycombView(_ sender: UIPinchGestureRecognizer) {
        
        if(sender.state == UIGestureRecognizer.State.began){
            //ピンチ開始時のアフィン変換をクラス変数に保持する。
            startTransform = honeycombView.transform
//            print(honeycombView.transform)
        }
        //ピンチ開始時のアフィン変換を引き継いでアフィン変換を行う。
        honeycombView.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }
    
    
    
    
    @IBAction func didClickToList(_ sender: UIButton) {
        
        //Realmに接続
        let realm = try! Realm()
        
        //中央の蜂の巣にデータがあるか確認
        let result = realm.objects(IdeaData.self)
            .filter("attributeId == \(generalAttributeId) AND tagNumber == \(100)")
        
        if result.first != nil {
            
            //データがあれば画面遷移
            performSegue(withIdentifier: "toList", sender: nil)
            
        } else {
            
            //データがない場合にはインフォメーションを出す
            SCLAlertView().showWarning(
                "一覧表示ができません", // タイトル
                subTitle: "蜂の巣の中央に\n『中心課題』を\n入力してください", // サブタイトル
                closeButtonTitle: "OK", // クローズボタンのタイトル
    //            timeout: 2, // **秒ごに、自動的に閉じる（OKでも閉じることはできる）
                colorStyle: 0xFFCF2F, // ボタン、シンボルの色
                colorTextButton: 0x000000, // ボタンの文字列の色
    //            circleIconImage: UIImage?, //アイコンimage
                animationStyle: .bottomToTop // スタイル（Success)指定
            )
        }

    }
   
    
    @IBAction func didClickToMakeHoneycomb(_ sender: UIButton) {
        
        var arrayStrings: [String] = []

        for i in 0...7  {
            for j in 0...6 {
                
                //初期値の設定
                var num: Int = i * 10 + j
                if num == 0 { num = 100 }
                
                //1から76までと100の蜂の巣を可視化
                if let  button = self.view.viewWithTag( num ) as? HexUIButton {
                    if num <= 6 {
                        
                        let text: String? = button.currentTitle
                        
                        if let titleText = text {
                            arrayStrings.append(titleText)
                        } else {
                            arrayStrings.append("")
                        }
                        
                    }
                    //不可視属性の指定を解除
                   button.isHidden = false
                }
            }
        }
        setHoneycombColor()
    }
    
    
    
    @IBAction func didClickGoToHoney(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toSetting", sender: nil)
        
    }
    
    @IBAction func didClickBee(_ sender: UIButton) {
        if  player.isPlaying {
            player.pause()
//            didClickButton.setTitle("一時停止", for: .normal)
        } else {
            player.play()
//            didClickButton.setTitle("再生中", for: .normal)
//            //            print("\(self.fileName) sound was played")
        }
    }
    
    @IBAction func inputTextButoon(_ sender: UIButton) {
        
//        print("\(#line)honeycombTagNum:\(honeycombTagNum)")
//        print(view.viewWithTag(10)?.isHidden as Any)

        //空文字かチェックする（guard let構文ここから）
        guard let text = inputBox.text else {
            //text.Field.textがnilの場合ボタンがクリックされたときの処理を中断
            return//以降の処理は実行されない
        }//（guard let構文ここまで）
        
        if text.isEmpty {
            //textField.textが空文字の場合ボタンがクリックされたときの処理を中断
            return //以降のボタンの処理は実行されない
        }
        
        if (honeycombTagNum > 6 && honeycombTagNum < 100) && view.viewWithTag(10)!.isHidden == true {
            
            SCLAlertView().showWarning(
                "登録できません", // タイトル
                subTitle: "蜂の巣を\n選択してください", // サブタイトル
                closeButtonTitle: "OK", // クローズボタンのタイトル
                //                timeout: 2 , // **秒ごに、自動的に閉じる（OKでも閉じることはできる）
                colorStyle: 0xFFCF2F, // ボタン、シンボルの色
                colorTextButton: 0x000000, // ボタンの文字列の色
                //            circleIconImage: UIImage?, //アイコンimage
                animationStyle: .bottomToTop // スタイル（Success)指定
            )
            
        } else {
            
            let button = self.view.viewWithTag(honeycombTagNum) as! HexUIButton
            //ideasの配列の中身が空の場合
            if button.currentTitle == nil {
                //新規ideaを追加
                createNewIdea(text, honeycombTagNum)
                
            } else if button.currentTitle == "" && dataResetToggle == true {
                //DeleteDataViewで新規作成されたものに対してのトラップ
                updateOldIdea(text, honeycombTagNum)
                dataResetToggle = false
                
            } else {
                //ideaの更新
                updateOldIdea(text, honeycombTagNum)
                
            }
            
            inputBox.text = ""
           
        }
        
        reloadHoneycombView()

    }
  

    fileprivate func setHoneycombColor() {
        var setHoneyBottle: Int = 0

        //ループ
        var num: Int = 0
        for i in 0...7 {
            for j in 0...6 {
                num = i * 10 + j
                if num == 0 {
                    num = 100
                }
                if let button = self.view.viewWithTag( num ) as? HexUIButton {
                    if button.titleLabel?.text == nil || button.titleLabel!.text!.isEmpty == true {
//                        print("\(#line)nilか？\(num):\(button.titleLabel・?.text)")
                    switch num {
                        case 100 :
                            button.buttonColor = UIColor.init(red: 255/255, green: 167/255, blue: 47/255, alpha: 0.4)
                            button.backgroundColor = UIColor.init(red: 255/255, green: 167/255, blue: 47/255, alpha: 0.4)
                        case 1,2,3,4,5,6 :
                            button.buttonColor = UIColor.init(red: 255/255, green: 207/255, blue: 47/255, alpha: 0.4)
                            button.backgroundColor = UIColor.init(red: 255/255, green: 207/255, blue: 47/255, alpha: 0.4)
                        case 10,20,30,40,50,60 :
                            button.buttonColor = UIColor.init(red: 255/255, green: 207/255, blue: 47/255, alpha: 0.4)
                            button.backgroundColor = UIColor.init(red: 255/255, green: 207/255, blue: 47/255, alpha: 0.4)
                        case 71...76:
                            button.buttonColor = UIColor.init(red: 255/255, green: 245/255, blue: 180/255, alpha: 0.4)
                            button.backgroundColor = UIColor.init(red: 255/255, green: 245/255, blue: 180/255, alpha: 0.4)
                        default:
                            button.buttonColor = UIColor.init(red: 255/255, green: 229/255, blue: 186/255, alpha: 0.4)
                            button.backgroundColor = UIColor.init(red: 255/255, green: 229/255, blue: 186/255, alpha: 0.4)
                        }
                    } else {
//                            print("\(#line)nilでない\(num):\(button.titleLabel?.text)")
                        setHoneyBottle = setHoneyBottle + 1
                        switch num {
                        case 100 :
                            button.buttonColor = UIColor.init(red: 255/255, green: 167/255, blue: 47/255, alpha: 1.0)
                            button.backgroundColor = UIColor.init(red: 255/255, green: 167/255, blue: 47/255, alpha: 1.0)
                        case 1,2,3,4,5,6 :
                            button.buttonColor = UIColor.init(red: 255/255, green: 207/255, blue: 47/255, alpha: 1.0)
                            button.backgroundColor = UIColor.init(red: 255/255, green: 207/255, blue: 47/255, alpha: 1.0)
                        case 10,20,30,40,50,60 :
                            button.buttonColor = UIColor.init(red: 255/255, green: 207/255, blue: 47/255, alpha: 1.0)
                            button.backgroundColor = UIColor.init(red: 255/255, green: 207/255, blue: 47/255, alpha: 1.0)
                        case 71...76:
                            button.buttonColor = UIColor.init(red: 255/255, green: 245/255, blue: 180/255, alpha: 1.0)
                            button.backgroundColor = UIColor.init(red: 255/255, green: 245/255, blue: 180/255, alpha: 1.0)
                        default:
                            button.buttonColor = UIColor.init(red: 255/255, green: 229/255, blue: 186/255, alpha: 1.0)
                            button.backgroundColor = UIColor.init(red: 255/255, green: 229/255, blue: 186/255, alpha: 1.0)
                        }
                    }
                } else {
//                 print("vc\(#line):Button\(num)はnil")
                }
            }
        }
        
//        print("\(#line)ハチミツの容量:\(setHoneyBottle)")
        //アイデアの量でbottleのハチミツが変化するギミック
        var imageName: String = ""
        let percentOfBottle = Int(floor(Double(setHoneyBottle) / 55 * 100))
        
        switch percentOfBottle {
        case 100 :
            imageName = "bottle100.png"
        case 86...99 :
            imageName = "bottle86.png"
        case 72...85 :
            imageName = "bottle72.png"
        case 60...71 :
            imageName = "bottle60.png"
        case 48...59 :
            imageName = "bottle48.png"
        case 36...47 :
            imageName = "bottle36.png"
        case 24...35 :
            imageName = "bottle24.png"
        case 1...23 :
            imageName = "bottle12.png"
        default:
            imageName = "bottle0.png"
        }
        
        let image = UIImage(named: imageName) as UIImage?
        self.bottle.setImage(image, for: .normal)
        
    }

    @objc func singleTap(_ gesture: UITapGestureRecognizer) {
        // シングルタップされた時の処理
        setHoneycombColor()

        print("\(#line)honeycombTagNum:\(honeycombTagNum)")
        
        if let button = self.view.viewWithTag(honeycombTagNum) as? HexUIButton {
            button.buttonColor = UIColor.init(red: 118/255, green: 214/255, blue: 255/255, alpha: 0.2)
            button.backgroundColor = UIColor.init(red: 118/255, green: 214/255, blue: 255/255, alpha: 0.2)
            button.setTitleColor(UIColor.black, for: .normal)
        }

    }
    
}
