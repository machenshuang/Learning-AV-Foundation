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
                } else {
                    let vc = UIAlertController(title: "Error", message: "Fail To load video", preferredStyle: .alert)
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
        
    }
}

