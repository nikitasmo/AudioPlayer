//
//  ModelStorage.swift
//  AudioPlayer
//
//  Created by Никита on 24/05/2023.
//  Copyright © 2023 com.example. All rights reserved.
//

import Foundation
import AVFoundation

class ModelStorage {
    
    var model = [AudioModel]()
    
    func addNewModel(audio: AVAudioPlayer, name: String) {
        model.append(AudioModel(audio: audio, name: name))
    }
    
    func getAudio(withName: String) -> AVAudioPlayer {
        for audioModel in model {
            if audioModel.name == withName {
                return audioModel.audio
            }
        }
        return model[0].audio
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
}
