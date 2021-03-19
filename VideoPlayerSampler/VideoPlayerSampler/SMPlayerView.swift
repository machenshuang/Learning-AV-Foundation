//
//  SMPlayerView.swift
//  VideoPlayerSampler
//
//  Created by 马陈爽 on 2021/3/19.
//

import UIKit
import AVFoundation

class SMPlayerView: UIView {
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.classForCoder()
    }
    
    func setupPlayer(with player: AVPlayer) {
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let layer = self.layer as! AVPlayerLayer
        layer.player = player
    }
    
    
    
}
