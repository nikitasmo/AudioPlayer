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
    
    var vcPlayer = ViewControllerPlayer()
    
    var presenter = Presenter()
    
    let mainView = MainView()
    
    var audioFiles = ["Dabro - На часах ноль-ноль", "Karna.val - Психушка", "NILETTO - Ты такая красивая"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.delegate = self
        vcPlayer.delegate = self
        
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
    func playAudio(index: Int) {
        
        if presenter.playingAudioCheck(index: index) == false && index != vcPlayer.currentAudio{
            presenter.stopPlayAllAudio()
            presenter.getAudioFromIndex(index: index).play()
        } else {
            presenter.getAudioFromIndex(index: index).play()
        }
        
        self.present(vcPlayer, animated: true, completion: nil)
    }
    
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

extension ViewController: vcPlayerTovcMain {
    func getCurrentTimeOfIndex(index: Int) -> Double {
        presenter.getCurrentTimeOfIndex(index: index)
    }
    
    func getDurationCurrentAudio(index: Int) -> Double {
        presenter.getDurationForIndexDouble(index: index)
    }
    
    func continuePlay(index: Int) {
        presenter.continuePlay(index: index)
    }
    
    func playingCheck(index: Int) -> Bool {
        presenter.playingAudioCheck(index: index)
    }
    
    func stopPlaying(index: Int) {
        presenter.stopAudioFromIndex(index: index)
    }
    
    func getIndexPlayingAudio() -> Int {
        presenter.getIndexPlayingAudio()
    }
    
}
