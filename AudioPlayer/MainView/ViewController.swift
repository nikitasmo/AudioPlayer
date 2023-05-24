//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Никита on 24/05/2023.
//  Copyright © 2023 com.example. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var presenter = Presenter()
    
    let mainView = MainView()
    
    var audioFiles = ["Dabro - На часах ноль-ноль", "Karna.val - Психушка"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.delegate = self
        
        view = mainView
        
        initialization()
        
    }
    
    func initialization() {
        for audioFile in audioFiles {
            if let path = Bundle.main.path(forResource: audioFile, ofType: "mp3") {
                let url = URL(fileURLWithPath: path)
                do {
                    let audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer.prepareToPlay()
                    presenter.addAudioInModel(audio: audioPlayer, name: audioFile)
                } catch {
                    print("Error loading file")
                }
            }
        }
    }


}

extension ViewController: userActionMain {
    func getDurationForIndex(index: Int) -> String {
        presenter.getDurationForIndex(index: index)
    }
    
    func getNameForIndex(index: Int) -> String {
        presenter.getnameForIndex(index: index)
    }
    
    func getCountAudio() -> Int {
        presenter.getCountOfAudio()
    }
    
}

