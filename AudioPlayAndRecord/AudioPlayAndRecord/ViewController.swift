//
//  ViewController.swift
//  AudioPlayAndRecord
//
//  Created by 马陈爽 on 2021/3/17.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func speechButtonClick(_ sender: UIButton) {
        let vc = AVSpeechViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func playButtonClick(_ sender: UIButton) {
        
    }
    
    @IBAction func recordButtonClick(_ sender: UIButton) {
    }
    
    
}

