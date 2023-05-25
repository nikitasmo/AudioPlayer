//
//  ViewControllerPlayer.swift
//  AudioPlayer
//
//  Created by Никита on 24/05/2023.
//  Copyright © 2023 com.example. All rights reserved.
//

import UIKit

protocol vcPlayerTovcMain: AnyObject {
    func getIndexPlayingAudio() -> Int
    func getDurationCurrentAudio(index: Int) -> Double
    func getCurrentTimeOfIndex(index: Int) -> Double
    func getNameForIndex(index: Int) -> String
    func stopPlaying(index: Int)
    func playingCheck(index: Int) -> Bool
    func continuePlay(index: Int)
}

class ViewControllerPlayer: UIViewController {
    
    let formatter = DateComponentsFormatter()
    
    var timer: Timer?
    
    weak var delegate: vcPlayerTovcMain?
    
    var viewPlayer = ViewPlayer()
    
    var currentAudio = Int()
    
    var durationCurrentAudio = Double()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewPlayer.delegate = self

        view = viewPlayer
        
        view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewPlayer.buttonPlay.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        
        currentAudio = delegate?.getIndexPlayingAudio() ?? 0
        
        durationCurrentAudio = delegate?.getDurationCurrentAudio(index: currentAudio) ?? 0
        
        viewPlayer.labelDuration.text = formatter.string(from: durationCurrentAudio)
        
        viewPlayer.labelName.text = delegate?.getNameForIndex(index: currentAudio).components(separatedBy: " - ")[1]
        
        viewPlayer.labelAuthor.text = delegate?.getNameForIndex(index: currentAudio).components(separatedBy: " - ")[0]
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
    }

}

extension ViewControllerPlayer {
    

    
    @objc func updateProgressView() {
        viewPlayer.progresView.progress = Float((delegate?.getCurrentTimeOfIndex(index: currentAudio) ?? 0)/durationCurrentAudio)
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        viewPlayer.labelCurrentTime.text = formatter.string(from: TimeInterval(delegate?.getCurrentTimeOfIndex(index: currentAudio) ?? 0))
        
    }
}

extension ViewControllerPlayer: viewPlayerToVc {
    func buttonPlayPressed() {
        if delegate?.playingCheck(index: currentAudio) == true {
            delegate?.stopPlaying(index: currentAudio)
            viewPlayer.buttonPlay.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            delegate?.continuePlay(index: currentAudio)
            viewPlayer.buttonPlay.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    func buttonClosePressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
