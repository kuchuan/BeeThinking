//
//  HexUIButton.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/08/05.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit

@IBDesignable

class HexUIButton: UIButton {

        
        @IBInspectable public var numberOfCorner : Int = 4
        @IBInspectable public var buttonColor : UIColor = UIColor.init(red: 249/255, green: 228/255, blue: 188/255, alpha: 1.0)
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
    
        //ポリゴンをコーナーの数で描画する
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

                //　Hexbuttonでボタンを作るとhoneycombTagNumが不正になるので気をつけるように！
                if honeycombTagNum != self.tag {

                    honeycombPreviousTagNum = honeycombTagNum

                    honeycombTagNum = self.tag

//                    print("HexUIButton\(#line):前のボタン\(honeycombPreviousTagNum)と今の薄い色のボタン\(honeycombTagNum)")

                }

                 return super.hitTest(point, with: event)
            }
        }
    
}


//（覚え書き）
////    // UIButtonのインスタンスを作成する
////    let hexLavel = UIButton(type: UIButtonType.system)
////
////    // ボタンを押した時に実行するメソッドを指定
////    hexButton.addTarget(self, action: #selector(buttonEvent(_:)), for: UIControlEvents.touchUpInside)
////
////    // ラベルを設定する
////    hexButton.setTitle("ボタンのテキスト", for: UIControlState.normal)
//
//override init(frame: CGRect) {
//    //ボタンのタイトル
//    hexButton.setTitle("hexButton", for: .normal)
//    
//    //ボタンのテキストカラー
//    hexButton.setTitleColor(.gray, for: .normal)
//    
//    //タップ時のテキスト
//    hexButton.setTitle("tapButtonTitle", for: .highlighted)
//    
//    //タップ時のテキストカラーの定義
//    hexButton.setTitleColor(UIColor.red, for: .highlighted)
//    
//    //ボタンのフレームサイズ
//    //        hexButton.frame = CGRectMake(0, 0, 200, 30)
//    hexLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 140)
//    
//    //ボタンの場所
//    hexLabel.layer.position = CGPoint(x: 0, y: 0)
//    
//    //ボタンの背景書
//    hexLabel.backgroundColor = UIColor.clear
//    
//    //ボタンの角丸
//    hexLabel.layer.cornerRadius = 0
//    
//    //ボタンの枠線定義
//    hexLabel.layer.borderWidth = 0
//    
//    //ボタンの枠のり色定義
//    hexLabel.layer.borderColor =  UIColor.red.cgColor
//    
//    //ボタンタップ時に実行するメソッド
//    hexButton.addTarget(self, action: Selector("touchUpButton:"), for: .touchUpInside)
//    
//    //ボタンの挙動を表示
//    func  touchUpButton() {
//        print("Button Touch Up!")
//    }
//    
//    //ボタンのタグ（ボタンを特定するために使用する）
//    hexLabel.tag = 1
//    
//    //文字に対する余白の設定content
//    hexButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
//    //文字に対する余白の設定Edge
//    hexButton.titleEdgeInsets = UIEdgeInsets(top: 22.0, left: 22.0, bottom: 22.0, right: 22.0)
//    
//    //お文字のサイズに関して広さの変更
//    hexButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
//    hexButton.titleLabel?.adjustsFontSizeToFitWidth = true
//    
//    //ボタンの有効・無効
//    hexLabel.isEnabled = true
//    
//    //ボタンの表示・非表示
//    hexLabel.isHidden = true
//    
//    //ボタンタイトルのマルチライン（ボタンの無効時･･･ラベルと同じになるらしい）
//    hexButton.titleLabel?.numberOfLines = 6
//    
//}
//
//required init?(coder aDecoder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//}
//// viewに追加する
//self.view.addSubview(button)
