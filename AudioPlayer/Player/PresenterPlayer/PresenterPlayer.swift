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
}

final class PresenterPlayer {
    
    private weak var view: IViewControllerPlay?
    
    init(view: IViewControllerPlay) {
        self.view = view
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
//        view?.setImageButtonPlayToPause()
//        ModelStorage.shared.setCurrentAudio(index: getIndexPlayingAudio())
    }
    
    func playNextAudio(index: Int) {
            
        if index == getCountOfAudio() - 1 { //если сейчас играет последний трек, то открываем первый
            playNewAudio(index: 0)
    //           mainView.MainTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .bottom)
        } else { // в остальных случаях включаем следующий трек
            playNewAudio(index: index + 1)
    //           mainView.MainTableView.selectRow(at: IndexPath(row: index + 1, section: 0), animated: true, scrollPosition: .bottom)
        }
    }
    
    func playPreviousAudio(index: Int) {   // вызывается при нажатии кнопки "предыдущая музыка"
        if index == 0 { //если сейчас играет первый трек, то открываем последний
            playNewAudio(index: getCountOfAudio() - 1)
//            mainView.MainTableView.selectRow(at: IndexPath(row: presenter.getCountOfAudio() - 1, section: 0), animated: true, scrollPosition: .bottom)
        } else { // в остальных случаях открываем предыдущий трек
            playNewAudio(index: index - 1)
//            mainView.MainTableView.selectRow(at: IndexPath(row: index - 1, section: 0), animated: true, scrollPosition: .bottom)
        }
    }
        
        func playNewAudio(index: Int) { // вызывается при открытии аудио, которое в данный момент не играет и не стоит на паузе
            stopPlayAllAudio() // сбрасывает всю музыку на ноль, чтобы при повторнм открытии аудио играло с нуля
            getAudioFromIndex(index: index).play()
        }
    
    
}
