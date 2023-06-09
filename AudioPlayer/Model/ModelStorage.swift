//
//  ModelStorage.swift
//  AudioPlayer
//
//  Created by Никита on 24/05/2023.
//  Copyright © 2023 com.example. All rights reserved.
//

import Foundation
import AVFoundation

final class ModelStorage {
    
    private init() {}
    
    static let shared = ModelStorage()
    
    private var model = [AudioModel]()
    
    private var currentAudio = Int()
    
    func addNewModel(audio: AVAudioPlayer, name: String) {
        model.append(AudioModel(audio: audio, name: name))
    }
    
    func getAudioFromIndex(index: Int) -> AVAudioPlayer {
        return model[index].audio
    }
    
    func getCountOfAudio() -> Int {
        return model.count
    }
    
    func getNameForIndex(index: Int) -> String {
        return model[index].name
    }
    
    func getDurationForIndex(index: Int) -> Double {
        return model[index].audio.duration
    }
    
    func stopPlayAllAudio() {
        for audiModel in model {
            audiModel.audio.stop()
            audiModel.audio.currentTime = 0
        }
    }
    
    func playingAudioCheck(index: Int) -> Bool {
        if model[index].audio.isPlaying == true {
            return true
        } else {
            return false
        }
    }
    
    func getIndexPlayingAudio() -> Int {
        for i in 0...(model.count - 1) {
            if model[i].audio.isPlaying == true {
                return i
            }
        }
        return 0
    }
    
    func stopAudiofromIndex(index: Int) {
        model[index].audio.stop()
    }
    
    func continuePlayFromIndex (index: Int) {
        model[index].audio.play()
    }
    
    func getCurrentTimeOfIndex(index: Int) -> Double {
        model[index].audio.currentTime
    }
    
    func getCurrentAudio() -> Int {
        currentAudio
    }
    
    func setCurrentAudio(index: Int) {
        currentAudio = index
    }

}
