//
//  ViewController.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/07/13.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit
import RevealingSplashView

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
        
        
//          //多角形
//        let myView = MyView(frame: view.bounds)
//        myView.backgroundColor = UIColor.white
//        myView.alpha = 0.5
//        HoneycombView.addSubview(myView)
        

        
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


//class MyView: UIView {
//    override func draw(_ rect: CGRect) {
//        let path = UIBezierPath()
//        var pointx = 207.0
//        var pointy = 221.0
//        var hexSize = 141.0
//        path.move(to: CGPoint(x: CGFloat(pointx - hexSize / 2 ), y: CGFloat(pointy)))
//        path.addLine(to: CGPoint(x: CGFloat(pointx - hexSize / 4), y: CGFloat(pointy + sin(Double.pi / 180 * 60 ) * hexSize / 2 )))
//        path.addLine(to: CGPoint(x: CGFloat(pointx + hexSize / 4), y: CGFloat(pointy + sin(Double.pi / 180 * 60 ) * hexSize / 2 )))
//        path.addLine(to: CGPoint(x: CGFloat(pointx + hexSize / 2), y: CGFloat(pointy)))
//        path.addLine(to: CGPoint(x: CGFloat(pointx + hexSize / 4), y: CGFloat(pointy - sin(Double.pi / 180 * 60 ) * hexSize / 2 )))
//        path.addLine(to: CGPoint(x: CGFloat(pointx - hexSize / 4), y: CGFloat(pointy - sin(Double.pi / 180 * 60 ) * hexSize / 2 )))
//        UIColor.darkGray.setFill() // 色をセット
//        path.fill()
//
//        "MyText".draw(at: CGPoint(x: 100, y: 100), withAttributes: [
//            NSAttributedString.Key.foregroundColor : UIColor.blue,
//            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 50),
//            ])
//    }
//}


@IBDesignable

class PolygonButton: UILabel {
    
    @IBInspectable public var numberOfCorner : Int = 4
    @IBInspectable public var buttonColor : UIColor = UIColor.black
    @IBInspectable public var rotation : Double = 0
    
    public let borderShape = CAShapeLayer()
    
    // Attributes Inspectorで設定した値を反映
    override func draw(_ rect: CGRect) {
        drawPolygon(numberOfCorner: numberOfCorner)
    }
    
    private func drawPolygon(numberOfCorner: Int) {
        let path = createPolygonPath(numberOfCorner: numberOfCorner)
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        self.layer.masksToBounds = true
        self.layer.mask = mask
        
        borderShape.path = path.cgPath
        borderShape.lineWidth = 1.0
        borderShape.strokeColor = buttonColor.cgColor
        borderShape.fillColor = buttonColor.cgColor
        self.layer.insertSublayer(borderShape, at: 0)
    }
    
    private func createPolygonPath(numberOfCorner:Int) -> UIBezierPath {
        let path = UIBezierPath()
        
        let center_x = self.center.x - self.frame.origin.x
        let center_y = self.center.y - self.frame.origin.y
        
        let rot = rotation * Double.pi / 180
        
        for i in 0..<numberOfCorner {
            let rad = rot + Double.pi * Double(i) * 2.0 / Double(numberOfCorner) - Double.pi / 2
            let drawPoint:CGPoint =
                CGPoint(x: center_x + self.frame.width / 2 * CGFloat(cos(rad)) ,
                        y: center_y - self.frame.height / 2 * CGFloat(sin(rad)) )
            if i==0 {
                path.move(to: drawPoint)
            } else {
                path.addLine(to: drawPoint)
            }
        }
        path.close()
        return path
    }
    
    //余白部分のタッチは無効にする
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !createPolygonPath(numberOfCorner:numberOfCorner).contains(point) {
            // タッチ領域外
            return nil
        } else {
//            print("タッチ")
            return super.hitTest(point, with: event)
        }
    }
    
}
