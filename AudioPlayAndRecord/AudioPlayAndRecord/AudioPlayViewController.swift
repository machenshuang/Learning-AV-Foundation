//
//  AudoPlayViewController.swift
//  AudioPlayAndRecord
//
//  Created by 马陈爽 on 2021/3/17.
//

import UIKit
import AVFoundation

class AudioPlayViewController: UIViewController {
    
    private var players: [AVAudioPlayer]!
    
    private var isPlaying: Bool = false
    
    @IBOutlet weak var playButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bassPlayer = self.audioPlayer(for: "bass")
        let drumsPlayer = self.audioPlayer(for: "drums")
        let guitarPlayer = self.audioPlayer(for: "guitar")
        guitarPlayer.delegate = self
        
        self.players = [bassPlayer, drumsPlayer, guitarPlayer]
        
        
        // Do any additional setup after loading the view.
    }
    
    func audioPlayer(for name: String) -> AVAudioPlayer {
        let filePath = Bundle.main.path(forResource: name, ofType: "caf")
        let fileURL = URL(fileURLWithPath: filePath!)
        do {
            let player = try AVAudioPlayer(contentsOf: fileURL, fileTypeHint: "caf")
            player.numberOfLoops = -1   // -1 表示无限循环
            player.enableRate = true    // 可调节速率
            player.prepareToPlay()
            return player
        } catch {
            fatalError()
        }
        
    }
    

    @IBAction func buttonClick(_ sender: UIButton) {
        if !self.isPlaying {
            // 所有音频延迟0.01s，为了可以同时播放
            let delayTime = self.players[0].deviceCurrentTime + 0.01
            for player in self.players {
                player.play(atTime: delayTime)
            }
            self.isPlaying = true
            sender.setTitle("Stop", for: .normal)
        } else {
            for player in self.players {
                player.stop()
                player.currentTime = 0.0
            }
            self.isPlaying = false
            sender.setTitle("Play", for: .normal)
        }
    }
    
    @IBAction func panValueChanged(_ sender: UISlider) {
        let player = self.players[sender.tag]
        player.pan = sender.value   // -1 ~ 1
    }
    
    @IBAction func volumnValueChanged(_ sender: UISlider) {
        let player = self.players[sender.tag]
        player.volume = sender.value   // 0 ~ 1
    }
    
    
    @IBAction func rateValueChanged(_ sender: UISlider) {
        for player in self.players {
            player.rate = sender.value  // -0.5 ~ 2
        }
    }
}

extension AudioPlayViewController: AVAudioPlayerDelegate {
    
}
