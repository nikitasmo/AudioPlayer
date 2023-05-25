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
    func stopPlaying(index: Int)
    func playingCheck(index: Int) -> Bool
    func continuePlay(index: Int)
}

class ViewControllerPlayer: UIViewController {
    
    weak var delegate: vcPlayerTovcMain?
    
    var viewPlayer = ViewPlayer()
    
    var currentAudio = Int()

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
