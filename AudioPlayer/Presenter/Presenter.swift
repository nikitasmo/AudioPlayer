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
    
    var model = ModelStorage()
    
    func addAudioInModel(audio: AVAudioPlayer, name: String) {
        model.addNewModel(audio: audio, name: name)
    }
    
    func getAudio(name: String) -> AVAudioPlayer {
        model.getAudio(withName: name)
    }
    
    func getCountOfAudio() -> Int {
        return model.getCountOfAudio()
    }
    
    func getnameForIndex(index: Int) -> String {
        return model.getNameForIndex(index: index)
    }
    
    func getDurationForIndex(index: Int) -> String {
        return String(format: "%.2f", model.getDurationForIndex(index: index) / 60)
    }
}
