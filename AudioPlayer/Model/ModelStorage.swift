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
    
}
