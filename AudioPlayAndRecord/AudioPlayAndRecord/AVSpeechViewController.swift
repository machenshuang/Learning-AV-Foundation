//
//  AVSpeechViewController.swift
//  AudioPlayAndRecord
//
//  Created by 马陈爽 on 2021/3/17.
//

import UIKit
import AVFoundation

class AVSpeechViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var label: UILabel!
    private var synthesizer: AVSpeechSynthesizer!
    //private var voices: [AVSpeechSynthesisVoice]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let x: CGFloat = 0
        let y: CGFloat = IsFullScreen ? 44.0 : 0.0
        let width = self.view.bounds.width
        let height = IsFullScreen ? self.view.bounds.height - 44 - 34 : self.view.bounds.height
        
        self.scrollView = UIScrollView(frame: CGRect(x: x, y: y, width: width, height: height))
        self.scrollView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        self.view.addSubview(self.scrollView)
        
        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        self.label.numberOfLines = 0
        self.label.text = SpeechString
        self.label.textColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        self.label.sizeToFit()
        self.scrollView.addSubview(self.label)
        self.scrollView.contentSize = CGSize(width: width, height: self.label.frame.height)
        // Do any additional setup after loading the view.
        
        self.synthesizer = AVSpeechSynthesizer()
        let voice = AVSpeechSynthesisVoice(language: "zh-CN")!
        
        
        let utterance = AVSpeechUtterance(string: SpeechString)
        utterance.voice = voice
        utterance.rate = 0.5
        utterance.pitchMultiplier = 0.8
        utterance.postUtteranceDelay = 0.12
        self.synthesizer.speak(utterance)
        
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


var IsFullScreen: Bool {
    guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
        return false
    }
    
    if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
        print(unwrapedWindow.safeAreaInsets)
        return true
    }
    return false
}

let SpeechString: String = "\t1805年7月，拿破仑征服了欧洲中西部的国家，法俄之间酝酿着可能的战争气氛。然而在彼得堡上层的人们依旧过着贵族们安逸悠闲的生活，某个晚上达官贵人们都聚集在皇太后的女官兼宠臣安娜·帕夫罗芙娜·舍雷尔（Anna Pavlovna）举办的社交聚会上。赴宴中有官高位重的华西里公爵（Prince Vassily Kuragin）、他倍受瞩目的美丽女儿海伦（Helene Kuragin）与高壮戴着眼镜的年轻人皮埃尔。皮埃尔（Pierre Bezukhov）是莫斯科著名贵族别祖霍夫的私生子，由于与华西里公爵有着亲属关系，暂居于其住处。他在法国留学后到首都谋职。在宴会中他遇到了聪明又略为妒世的老朋友安德烈（Prince Andrei Bolkonsky）。安德烈是先朝的退职老总司令保尔康斯基的长子，与其有孕的妻子丽莎出席宴会。但安德烈在婚后对其妻子丽莎的肤浅感到无奈，并对彼得堡的贵族生活毫无兴趣。\n\n\t此时，安德烈命中注定参与库图佐夫将军的征召，出任他的传令官，将出国跟征战欧洲的拿破仑军队作战。即将分娩的妻子丽莎和信仰虔诚的妹妹玛丽雅虽再三劝留，也改变不了他的决心，他期望通过这次战争为自己带来辉煌与荣耀。在出征之前，安德烈把妻子从首都送到了在莫斯科郊外童山居住的父亲保尔康斯基公爵那里，委托父亲加以关照。于是他前往前线，在波兰追上了俄军总司令库图佐夫（General Kutuzov），总司令派他到联合纵队去任职，并受到了嘉奖。\n\n\t在莫斯科，贵族罗斯托夫（Count Ilya Rostov）共有四位青少年子女。13岁的娜塔莎认为自己爱上了保里斯(Prince Boris Drubetskoy)，一位有志气而即将入伍的军官。20岁的长子尼古拉与保里斯相同，即将入伍从军。尼古拉（Nikolai Rostov）钟情于长年寄住在罗斯托夫的表妹宋妮雅(Sonya Alexandrovna)，自小就是孤儿的宋妮雅亦专情于尼古拉。长女薇拉（Vera Rostov），略为高傲的个性则与在俄罗斯从军的德国军官别尔格相恋。彼嘉（Petya Rostov）是家族最年轻的幼子，希望成年能跟随尼古拉的脚步从军。罗斯托夫伯爵则因一直以来家族财务窘境而困扰不已。\n\n\t俄奥联军对法的奥斯特里茨战役(1805年12月2日)已于战争前夕，由于在战前的军事会议上，主战的将军意见主导了俄军的攻势，在误判了法军的阵线后，俄军遭法军所击溃。战役中尼古拉对沙皇亚历山大的魅力深深着迷，且尼古拉作为少尉在中队骠骑兵首次尝试了战斗。而安德烈却在战役中受伤被俘，在受伤当下对自己先前天真的作战意识有了重大的改变，且对后来视察俘虏的拿破仑不再抱持原有对其崇拜的思维，相反由濒临死亡的体验产生了一些严肃而壮丽的想法。之后安德烈被法军诊断其伤势过重不可能活下去而被留下由当地居民照顾。"
