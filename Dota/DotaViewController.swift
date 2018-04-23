//
//  ViewController.swift
//  Dota
//
//  Created by Baran on 24.04.2018.
//  Copyright © 2018 CodingMind. All rights reserved.
//

import UIKit
import FSPagerView
import CountdownLabel
import AVFoundation

class DotaViewController: UIViewController {

    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    let imageArray = [#imageLiteral(resourceName: "dota1"),#imageLiteral(resourceName: "dota2"),#imageLiteral(resourceName: "dota3"),#imageLiteral(resourceName: "dota4"),#imageLiteral(resourceName: "dota5"),#imageLiteral(resourceName: "dota6"),#imageLiteral(resourceName: "dota7"),#imageLiteral(resourceName: "dota8"),#imageLiteral(resourceName: "dota9"),#imageLiteral(resourceName: "dota10")]
    @IBOutlet weak var gradiendView: UIView!
    @IBOutlet weak var countLabel: CountdownLabel!
    @IBOutlet weak var playButton: UIButton!
    var audioPlayer = AVAudioPlayer()
    
    var appState = timerState.firtPlay
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurePagerView()
        self.gradientConfigure()
        self.addDelegate()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.startingConfigure()
    }

    
    @IBAction func playButtonAct(_ sender: UIButton) {
        switch appState {
        case .pause:
            countLabel.start()
            playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            appState = .play
        case .play:
            countLabel.pause()
            playButton.setImage(#imageLiteral(resourceName: "play-button"), for: .normal)
            appState = .pause
        case .firtPlay:
            self.labelCongigure()
            appState = .play
        }
    }
    
    @IBAction func resetButtonAct(_ sender: Any) {
        self.labelCongigure()
        playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
    }
    
    
    

}

extension DotaViewController{
    func startingConfigure(){
        self.playTrackOrPlaylist(resource: voiceURL.startApp.rawValue)
    }
    
    func configurePagerView(){
        self.pagerView.delegate = self
        self.pagerView.dataSource = self
        self.pagerView.transformer = FSPagerViewTransformer(type: .linear)
        self.pagerView.isInfinite = true
        self.pagerView.automaticSlidingInterval = 10.0
    }
    
    func gradientConfigure() {
         let colors = [UIColor.black.withAlphaComponent(0.1).cgColor,UIColor.black.withAlphaComponent(0.8).cgColor]
         self.gradiendView.layer.addVerticalGradientLayer(size: self.view.frame.size, colors: colors)
    }
    
    func labelCongigure() {
        countLabel.animationType = .Scale
        countLabel.setCountDownTime(minutes: 120)
        countLabel.timeFormat = "mm:ss"
        countLabel.start()
        playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
    }
    
    func addDelegate(){
        countLabel.countdownDelegate = self
    }
    
}

//Mark: -For Slider
extension DotaViewController : FSPagerViewDelegate, FSPagerViewDataSource {
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageArray.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.image = imageArray[index]
        
        return cell
    }
    
}

//Mark: -For Slider
extension DotaViewController: CountdownLabelDelegate {
    func countdownFinished() {
        labelCongigure()
    }
    func countingAt(timeCounted: TimeInterval, timeRemaining: TimeInterval) {
        if timeCounted == 30.0 {
            self.playTrackOrPlaylist(resource: voiceURL.stack1.rawValue)
        } else if timeCounted == 45 {
            self.playTrackOrPlaylist(resource: voiceURL.stack2.rawValue)
        } else if timeCounted == 90 {
            self.playTrackOrPlaylist(resource: voiceURL.stack3.rawValue)
        } else if timeCounted == 105 {
            self.playTrackOrPlaylist(resource: voiceURL.stack4.rawValue)
        } else if timeCounted == 110 {
            self.playTrackOrPlaylist(resource: voiceURL.rune.rawValue)
        }
//        debugPrint("time counted at delegate=\(timeCounted)")
//        debugPrint("time remaining at delegate=\(timeRemaining)")
    }
    
}

//Mark: -For Audio
extension DotaViewController {

    func playTrackOrPlaylist(resource : String){
        
        let audioFilePath = Bundle.main.path(forResource: resource, ofType: "mp3")
        //print(resource)
        
        if audioFilePath != nil {
            let audioFileUrl = NSURL.fileURL(withPath: audioFilePath!)
            do {
                
                audioPlayer = try AVAudioPlayer(contentsOf: audioFileUrl)
                audioPlayer.play()
            }
            catch
            {
                print("An error occurred while trying to extract audio file")
            }
            
        } else {
            print("audio file is not found")
        }
        
    }
}

enum timerState {
    case play
    case pause
    case firtPlay
}

enum voiceURL : String {
    case startApp = "Music_default_stinger01"
    case stack1 = "Music_default_gank_md_01"
    case stack2 = "Music_default_ganked_lg_01"
    case stack3 = "Music_default_ganked_med_02"
    case stack4 = "Music_default_quest_complete_01"
    case rune  = "Music_default_stinger03"
}
