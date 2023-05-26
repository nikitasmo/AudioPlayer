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

final class Presenter: IPresenter {
    
    private let formatter = DateComponentsFormatter()
    
    private var modelStorage = ModelStorage()
    
    func addAudioInModel(audio: AVAudioPlayer, name: String) {
        modelStorage.addNewModel(audio: audio, name: name)
    }
    
    func getAudioFromIndex(index: Int) -> AVAudioPlayer {
        modelStorage.getAudioFromIndex(index: index)
    }
    
    func getCountOfAudio() -> Int {
        return modelStorage.getCountOfAudio()
    }
    
    func getnameForIndex(index: Int) -> String {
        return modelStorage.getNameForIndex(index: index)
    }
    
    func getDurationForIndex(index: Int) -> String {
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: modelStorage.getDurationForIndex(index: index)) ?? ""
    }
    
    func getDurationForIndexDouble(index: Int) -> Double {
        return modelStorage.getDurationForIndex(index: index)
    }
    
    func stopPlayAllAudio() {
        modelStorage.stopPlayAllAudio()
    }
    
    func playingAudioCheck(index: Int) -> Bool {
        modelStorage.playingAudioCheck(index: index)
    }
    
    func getIndexPlayingAudio() -> Int {
        modelStorage.getIndexPlayingAudio()
    }
    
    func stopAudioFromIndex(index: Int) {
        modelStorage.stopAudiofromIndex(index: index)
    }
    
    func continuePlay(index: Int) {
        modelStorage.continuePlayFromIndex(index: index)
    }
    
    func getCurrentTimeOfIndex(index: Int) -> Double {
        modelStorage.getCurrentTimeOfIndex(index: index)
    }
    

    
}
