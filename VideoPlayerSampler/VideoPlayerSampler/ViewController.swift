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
    private var timeObserver: Any?
    private var itemEndObserver: Any?
    
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
                    self.addPlayerItemTimeObserver()
                    self.addItemEndObserverForPlayerItem()
                    self.player.play()
                    self.isPlaying = false
                } else {
                    let vc = UIAlertController(title: "Error", message: "Fail To load video", preferredStyle: .alert)
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    private func addPlayerItemTimeObserver() {
        //创建0.5s间隔刷新
        let interval = CMTimeMakeWithSeconds(0.5, preferredTimescale: Int32(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        self.timeObserver = self.player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { (time) in
            let currentTime = CMTimeGetSeconds(time)
            let duration = CMTimeGetSeconds(self.playerItem.duration)
            let currentSecond = Int(ceil(currentTime))
            let remainingTime = Int(duration - currentTime)
            self.playeredTimeLab.text = self.formatSeconds(value: currentSecond)
            self.unPlayTimeLabel.text = self.formatSeconds(value: remainingTime)
            self.seekTimeSlider.minimumValue = 0.0
            self.seekTimeSlider.maximumValue = Float(duration)
            self.seekTimeSlider.value = Float(currentTime)
        })
    }
    
    private func addItemEndObserverForPlayerItem() {
        self.itemEndObserver = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.playerItem, queue: OperationQueue.main, using: { (noti) in
            self.player.seek(to: .zero) { (finished) in
                self.isPlaying = false
                self.playerButton.setTitle("PLAY", for: .normal)
            }
        })
    }
    
    private func formatSeconds(value: Int) -> String{
        let second = value % 60
        let minutes = value / 60
        return String(format: "%0.2ld:%0.2ld", minutes, second)
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
        self.player.seek(to: CMTimeMakeWithSeconds(Float64(sender.value), preferredTimescale: Int32(NSEC_PER_SEC)))
    }
}

