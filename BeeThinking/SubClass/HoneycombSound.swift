//
//  HoneycombSound.swift
//  Beethinking
//
//  Created by 堀川浩二 on 2019/09/03.
//  Copyright © 2019 堀川浩二. All rights reserved.
//

import Foundation
import AVFoundation

class HoneycombSound {
    
    //インスタンス
    
    var playSwich: String = "stop"
    
    //カセットデッキ的なやつ
    var player: AVAudioPlayer!
    
    
    //メソッド
    func playSound(soundState playSwich: String, soundOfTimes times: Int) -> String {

        
        let audioPath = Bundle.main.path(forResource: "BeeThinking", ofType: "mp3")!
        
        //URLにする必要があるので･･･
        let audioUrl = URL(fileURLWithPath: audioPath)
        
        //音楽ファイルを元に、プレイユアー作成
        //以下だとエラーが出る。Do catchで作ると
        do {
        player = try AVAudioPlayer(contentsOf: audioUrl)
        
        //無限ループ
        player.numberOfLoops = -1 //ループ再生 （times変数利用余地絵）
        
        } catch let error {
            print(error.localizedDescription)
        }
        
        //再生
//        player.delegate = self //おまじない･･･ここがわからん
        player.prepareToPlay() //再生の準備
        
        return "演奏状態"
        
    }
    
}

