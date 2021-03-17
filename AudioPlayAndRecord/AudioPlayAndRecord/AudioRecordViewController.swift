//
//  AudioRecordViewController.swift
//  AudioPlayAndRecord
//
//  Created by 马陈爽 on 2021/3/17.
//

import UIKit
import AVFoundation

class AudioRecordViewController: UIViewController {
    
    private var player: AVAudioPlayer!
    private var recorder: AVAudioRecorder!
    
    private var levelTimer: CADisplayLink!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tmpDir = NSTemporaryDirectory()
        let filePath = tmpDir.appending("memo.caf")
        let fileURL = URL(fileURLWithPath: filePath)
        
        let setting: [String: Any] = [
            AVFormatIDKey: kAudioFormatAppleIMA4,   // 音频格式
            AVSampleRateKey: 44100.0,   // 采样率
            AVNumberOfChannelsKey: 1,   // 通道数
            AVEncoderBitDepthHintKey: 16,   // 深度
            AVEncoderAudioQualityKey: AVAudioQuality.medium // 音质
        ]
        do {
            self.recorder = try AVAudioRecorder(url: fileURL, settings: setting)
            self.recorder.delegate = self
            self.recorder.isMeteringEnabled = true
            self.recorder.prepareToRecord()
        } catch {
            fatalError(error.localizedDescription)
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startRecording(_ sender: UIButton) {
        self.recorder.record()
    }
    
    @IBAction func stopRecording(_ sender: UIButton) {
        self.recorder.stop()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AudioRecordViewController: AVAudioPlayerDelegate, AVAudioRecorderDelegate, UITableViewDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("url:\(recorder.url)")
    }
    
    
}

