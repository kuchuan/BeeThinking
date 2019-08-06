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
        @IBInspectable public var buttonColor : UIColor = UIColor.gray
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
                            print("タッチ")
                return super.hitTest(point, with: event)
            }
        }
        
}
