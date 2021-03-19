//
//  ViewController.swift
//  VideoPlayerSampler
//
//  Created by 马陈爽 on 2021/3/19.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private let localURL = Bundle.main.url(forResource: "hubblecast", withExtension: "m4v")
    private var asset: AVAsset!
    private var playerItem: AVPlayerItem!
    private var player: AVPlayer!
    
    @IBOutlet weak var playerView: SMPlayerView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var playerButton: UIButton!
    @IBOutlet weak var playeredTimeLab: UILabel!
    @IBOutlet weak var unPlayTimeLabel: UILabel!
    @IBOutlet weak var seekTimeSlider: UISlider!
    
    private var isPlaying: Bool = false
    
    private var playerStatusObserver: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.asset = AVAsset(url: self.localURL!)
        self.prepareToPlay()
    }

    func prepareToPlay() {
        let keys: [String] = [
            "tracks",
            "duration",
            "commonMetadata",
            "availableMediaCharacteristicsWithMediaSelectionOptions"
        ]
        self.playerItem = AVPlayerItem(asset: self.asset, automaticallyLoadedAssetKeys: keys)
        self.player = AVPlayer(playerItem: self.playerItem)
        self.playerView.setupPlayer(with: self.player)
        self.playerStatusObserver = self.playerItem.observe(\.status, options: [.new]) { (playerItem, change) in
            DispatchQueue.main.async {
                if playerItem.status == .readyToPlay {
                    self.player.play()
                    self.isPlaying = false
                } else {
                    let vc = UIAlertController(title: "Error", message: "Fail To load video", preferredStyle: .alert)
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @IBAction func playerButtonClick(_ sender: UIButton) {
        if self.isPlaying {
            self.player.pause()
            self.isPlaying = false
            self.playerButton.setTitle("PLAY", for: .normal)
        } else {
            self.player.play()
            self.isPlaying = true
            self.playerButton.setTitle("STOP", for: .normal)
        }
    }
    
    @IBAction func seekSliderValueChanged(_ sender: UISlider) {
    }
}

