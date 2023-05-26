//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Никита on 24/05/2023.
//  Copyright © 2023 com.example. All rights reserved.
//

import UIKit
import AVFoundation

protocol IViewController: AnyObject {
    func initialization()
    func playNewAudio(index: Int)
}

final class ViewController: UIViewController {
    
    var vcPlayer = ViewControllerPlayer()
    
    let mainView = MainView()
    
    var audioFiles = ["Dabro - На часах ноль-ноль", "Karna.val - Психушка", "NILETTO - Ты такая красивая", "Rauf & Faik, NILETTO - Если тебе будет грустно", "T-killah, Matara - Люби меня люби"]
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    //MARK: - Dependency
    var presenter: IPresenter = {
        return Presenter()
    }()

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.delegate = self
        vcPlayer.delegate = self
        
        view = mainView
        
        initialization()
        
    }

}

//MARK: - IViewController
extension ViewController: IViewController {
    
    func initialization() {  //подготавливает треки к проигрыванию и вызывает функцию загрузки их в модель
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
    
    func playNewAudio(index: Int) { // вызывается при открытии аудио, которое в данный момент не играет и не стоит на паузе
        presenter.stopPlayAllAudio() // сбрасывает всю музыку на ноль, чтобы при повторнм открытии аудио играло с нуля
        presenter.getAudioFromIndex(index: index).play()
    }
    
}

//MARK: - userActionMain
extension ViewController: userActionMain {
    func playAudio(index: Int) {  // зпускает проигрывание музыки
        
        if presenter.playingAudioCheck(index: index) == false && index != vcPlayer.currentAudio{ //условие, если выбранная музыка не играет в данный момент и не стоит на паузе
            playNewAudio(index: index)
        } else {                                                                  //если мы открываем мызыку, которая стоит на паузе
            presenter.getAudioFromIndex(index: index).play()
        }
        
        self.present(vcPlayer, animated: true, completion: nil)                  // всегда открываем модальное окно плеера при нажатии на трек
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

//MARK: - vcPlayerTovcMain
extension ViewController: vcPlayerTovcMain {
    func playPreviousAudio(index: Int) {   // вызывается при нажатии кнопки "предыдущая музыка"
        if index == 0 { //если сейчас играет первый трек, то открываем последний
            playNewAudio(index: (presenter.getCountOfAudio() - 1))
            mainView.MainTableView.selectRow(at: IndexPath(row: presenter.getCountOfAudio() - 1, section: 0), animated: true, scrollPosition: .bottom)
        } else { // в остальных случаях открываем предыдущий трек
            playNewAudio(index: index - 1)
            mainView.MainTableView.selectRow(at: IndexPath(row: index - 1, section: 0), animated: true, scrollPosition: .bottom)
        }
    }
    
    func playNextAudio(index: Int) { // вызывается при нажатии кнопки "следующий трек"
        if index == (presenter.getCountOfAudio() - 1) { //если сейчас играет последний трек, то открываем первый
            playNewAudio(index: 0)
            mainView.MainTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .bottom)
        } else { // в остальных случаях включаем следующий трек
            playNewAudio(index: index + 1)
            mainView.MainTableView.selectRow(at: IndexPath(row: index + 1, section: 0), animated: true, scrollPosition: .bottom)
        }
    }
    
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
