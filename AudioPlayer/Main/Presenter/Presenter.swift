//
//  Presenter.swift
//  AudioPlayer
//
//  Created by Никита on 24/05/2023.
//  Copyright © 2023 com.example. All rights reserved.
//

import Foundation
import AVFoundation


class Presenter {
    
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
