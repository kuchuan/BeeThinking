//
//  ViewController.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/07/13.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
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
        // Do any additional setup after loading the view.
        let HoneycombBox = PolygonView.init(frame: CGRect(x:0, y:0, width:100, height:100))
            HoneycombBox.polygonNumber = 6
            HoneycombBox.fillColor = .orange
        
    }
    @IBAction func InputTextbutton(_ sender: UIButton) {
        HoneycombLabel00.text = InputBox.text
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

    }
    
    @IBAction func touchLabel02(_ sender: UITapGestureRecognizer) {
    
        resetBorderColor()
        //　ラベル枠の枠線太さと色
        HoneycombLabel02.layer.borderColor = UIColor.blue.cgColor
        HoneycombLabel02.layer.borderWidth = 3
    
    }

    @IBAction func touchLabel03(_ sender: UITapGestureRecognizer) {
        
        resetBorderColor()
        //　ラベル枠の枠線太さと色
        HoneycombLabel03.layer.borderColor = UIColor.blue.cgColor
        HoneycombLabel03.layer.borderWidth = 3
        
    }
    
    
    @IBAction func touchLabel04(_ sender: UITapGestureRecognizer) {
        
        resetBorderColor()
        //　ラベル枠の枠線太さと色
        HoneycombLabel04.layer.borderColor = UIColor.blue.cgColor
        HoneycombLabel04.layer.borderWidth = 3
    }
    
    @IBAction func touchLabel05(_ sender: UITapGestureRecognizer) {
        
        resetBorderColor()
        //　ラベル枠の枠線太さと色
        HoneycombLabel05.layer.borderColor = UIColor.blue.cgColor
        HoneycombLabel05.layer.borderWidth = 3
    }
    
    @IBAction func touchLabel06(_ sender: UITapGestureRecognizer) {
        
        resetBorderColor()
        //　ラベル枠の枠線太さと色
        HoneycombLabel06.layer.borderColor = UIColor.blue.cgColor
        HoneycombLabel06.layer.borderWidth = 3
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
    }
    
    
}



class PolygonView:UIView{
    
    //角の数
    var polygonNumber:Int = 6 {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    //図形の色
    var fillColor:UIColor = .black{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    override var frame: CGRect{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    override init(frame:CGRect){
        super.init(frame:frame)
        //色を塗らない部分を透過
        self.isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let r = min(rect.width/2, rect.height/2)
        let c = CGPoint(x: rect.width/2, y: rect.height/2)
        self.drawRegularPolygon(self.polygonNumber, radius: r, center: c)
    }
    
    //図形を描く
    func drawRegularPolygon(_ p: Int, radius: CGFloat, center: CGPoint) {
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        ctx.clear(self.frame)
        
        var pt:[CGPoint]=[]
        for i in 0 ..< p {
            let rad: CGFloat = CGFloat(Double.pi * Double(i) * 2.0 / Double(p) + Double.pi / 2.0)
            let point = CGPoint(x: center.x + radius * cos(rad), y: center.y - radius * sin(rad))
            pt.append(point)
        }
        
        ctx.setFillColor(self.fillColor.cgColor)
        
        ctx.move(to: pt[0])
        
        for p in pt{
            ctx.addLine(to: p)
        }
        ctx.closePath()
        ctx.fillPath()
    }
}
