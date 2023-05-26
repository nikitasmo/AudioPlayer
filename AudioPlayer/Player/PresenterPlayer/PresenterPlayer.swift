//
//  PresenterPlayer.swift
//  AudioPlayer
//
//  Created by Никита on 26/05/2023.
//  Copyright © 2023 com.example. All rights reserved.
//

import Foundation
import AVFoundation

protocol IPresenterPlayer: AnyObject {
    func getIndexPlayingAudio() -> Int
    func getDurationCurrentAudioDouble(index: Int) -> Double
    func getCurrentTimeOfIndex(index: Int) -> Double
    func getNameForIndex(index: Int) -> String
    func stopPlaying(index: Int)
    func playingCheck(index: Int) -> Bool
    func continuePlay(index: Int)
    func getCountOfAudio() -> Int
    func stopPlayAllAudio()
    func getAudioFromIndex(index: Int) -> AVAudioPlayer
    func playNextAudio(index: Int)
    func playPreviousAudio(index: Int)
    func viewWillAppear()
    func buttonPlyaPressed()
}

final class PresenterPlayer {
    
    private let formatter = DateComponentsFormatter()
    
    private weak var view: IViewControllerPlay?
    
    init(view: IViewControllerPlay) {
        self.view = view
        configFormatter()
    }
    
}

extension PresenterPlayer: IPresenterPlayer {
    
    func getIndexPlayingAudio() -> Int {
        ModelStorage.shared.getIndexPlayingAudio()
    }
    
    func getDurationCurrentAudioDouble(index: Int) -> Double {
        ModelStorage.shared.getDurationForIndex(index: index)
    }
    
    func getCurrentTimeOfIndex(index: Int) -> Double {
        ModelStorage.shared.getCurrentTimeOfIndex(index: index)
    }
    
    func getNameForIndex(index: Int) -> String {
        ModelStorage.shared.getNameForIndex(index: index)
    }
    
    func stopPlaying(index: Int) {
        ModelStorage.shared.stopAudiofromIndex(index: index)
    }
    
    func playingCheck(index: Int) -> Bool {
        ModelStorage.shared.playingAudioCheck(index: index)
    }
    
    func continuePlay(index: Int) {
        ModelStorage.shared.continuePlayFromIndex(index: index)
    }
    
    func getCountOfAudio() -> Int {
        ModelStorage.shared.getCountOfAudio()
    }
    
    func stopPlayAllAudio() {
        ModelStorage.shared.stopPlayAllAudio()
    }
    
    func getAudioFromIndex(index: Int) -> AVAudioPlayer {
        ModelStorage.shared.getAudioFromIndex(index: index)
    }
    

}

extension PresenterPlayer {
    
    func viewWillAppear() {
        view?.setImageButtonPlayToPause()
        
        ModelStorage.shared.setCurrentAudio(index: getIndexPlayingAudio())
        
        view?.setLabel(labelDuration: formatter.string(from: getDurationCurrentAudioDouble(index: ModelStorage.shared.getCurrentAudio())) ?? "",
                       labelName: getNameForIndex(index: ModelStorage.shared.getCurrentAudio()).components(separatedBy: " - ")[1],
                       labelAuthor: getNameForIndex(index: ModelStorage.shared.getCurrentAudio()).components(separatedBy: " - ")[0])
        
        var _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
        
    }
    
    func playNextAudio(index: Int) {
            
        if index == getCountOfAudio() - 1 { //если сейчас играет последний трек, то открываем первый
            playNewAudio(index: 0)
            view?.changeSelectRow(index: 0)
        } else { // в остальных случаях включаем следующий трек
            playNewAudio(index: index + 1)
            view?.changeSelectRow(index: index + 1)
        }
        
        viewWillAppear()
    }
    
    func playPreviousAudio(index: Int) {   // вызывается при нажатии кнопки "предыдущая музыка"
        if index == 0 { //если сейчас играет первый трек, то открываем последний
            playNewAudio(index: getCountOfAudio() - 1)
            view?.changeSelectRow(index: getCountOfAudio() - 1)
        } else { // в остальных случаях открываем предыдущий трек
            playNewAudio(index: index - 1)
            view?.changeSelectRow(index: index - 1)
        }
        
        viewWillAppear()
    }
    
    func buttonPlyaPressed() {
        if playingCheck(index: ModelStorage.shared.getCurrentAudio()) == true { //выполняется в случае, если музыка играет сейчас
            stopPlaying(index: ModelStorage.shared.getCurrentAudio())
            view?.setImageButtonPlayToPlay()
        } else {                                                //выполняется если музыка стоит на паузе
            continuePlay(index: ModelStorage.shared.getCurrentAudio())
            view?.setImageButtonPlayToPause()
        }
    }
        
    func playNewAudio(index: Int) { // вызывается при открытии аудио, которое в данный момент не играет и не стоит на паузе
        stopPlayAllAudio() // сбрасывает всю музыку на ноль, чтобы при повторнм открытии аудио играло с нуля
        getAudioFromIndex(index: index).play()
    }
    
    func configFormatter() {
        //настраиваем форматтер для правильного отображения времени
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
    }
    
}

//MARK: - Selectors
extension PresenterPlayer {
    @objc func updateProgressView() {
        view?.updateProgressView(value: Float(getCurrentTimeOfIndex(index: ModelStorage.shared.getCurrentAudio())/getDurationCurrentAudioDouble(index: ModelStorage.shared.getCurrentAudio()))) //вычисляем новое значение для progressView
        
        view?.updateLabelCurrentTime(value: formatter.string(from: TimeInterval(getCurrentTimeOfIndex(index: ModelStorage.shared.getCurrentAudio()))) ?? "")
        
        if playingCheck(index: ModelStorage.shared.getCurrentAudio()) == false && getCurrentTimeOfIndex(index: ModelStorage.shared.getCurrentAudio()) == 0 {
            playNextAudio(index: ModelStorage.shared.getCurrentAudio())
            viewWillAppear()
        }
    }
}
