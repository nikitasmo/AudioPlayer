//
//  Presenter.swift
//  AudioPlayer
//
//  Created by Никита on 24/05/2023.
//  Copyright © 2023 com.example. All rights reserved.
//

import Foundation
import AVFoundation


protocol IPresenter: AnyObject {
    func addAudioInModel(audio: AVAudioPlayer, name: String)
    func getAudio(name: String) -> AVAudioPlayer
    func getAudioFromIndex(index: Int) -> AVAudioPlayer
    func getCountOfAudio() -> Int
    func getnameForIndex(index: Int) -> String
    func getDurationForIndex(index: Int) -> String
    func getDurationForIndexDouble(index: Int) -> Double
    func stopPlayAllAudio()
    func playingAudioCheck(index: Int) -> Bool
    func getIndexPlayingAudio() -> Int
    func stopAudioFromIndex(index: Int)
    func continuePlay(index: Int)
    func getCurrentTimeOfIndex(index: Int) -> Double
}

class Presenter: IPresenter {
    
    let formatter = DateComponentsFormatter()
    
    var model = ModelStorage()
    
    func addAudioInModel(audio: AVAudioPlayer, name: String) {
        model.addNewModel(audio: audio, name: name)
    }
    
    func getAudio(name: String) -> AVAudioPlayer {
        model.getAudio(withName: name)
    }
    
    func getAudioFromIndex(index: Int) -> AVAudioPlayer {
        model.getAudioFromIndex(index: index)
    }
    
    func getCountOfAudio() -> Int {
        return model.getCountOfAudio()
    }
    
    func getnameForIndex(index: Int) -> String {
        return model.getNameForIndex(index: index)
    }
    
    func getDurationForIndex(index: Int) -> String {
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: model.getDurationForIndex(index: index)) ?? ""
    }
    
    func getDurationForIndexDouble(index: Int) -> Double {
        return model.getDurationForIndex(index: index)
    }
    
    func stopPlayAllAudio() {
        model.stopPlayAllAudio()
    }
    
    func playingAudioCheck(index: Int) -> Bool {
        model.playingAudioCheck(index: index)
    }
    
    func getIndexPlayingAudio() -> Int {
        model.getIndexPlayingAudio()
    }
    
    func stopAudioFromIndex(index: Int) {
        model.stopAudiofromIndex(index: index)
    }
    
    func continuePlay(index: Int) {
        model.continuePlayFromIndex(index: index)
    }
    
    func getCurrentTimeOfIndex(index: Int) -> Double {
        model.getCurrentTimeOfIndex(index: index)
    }
    

    
}
