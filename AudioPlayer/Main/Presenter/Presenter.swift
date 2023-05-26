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
    func viewDidLoad()
    func addAudioInModel(audio: AVAudioPlayer, name: String)
    func getAudioFromIndex(index: Int) -> AVAudioPlayer
    func getCountOfAudio() -> Int
    func getnameForIndex(index: Int) -> String
    func getDurationForIndex(index: Int) -> String
    func getDurationForIndexDouble(index: Int) -> Double
    func stopPlayAllAudio()
    func playingAudioCheck(index: Int) -> Bool
    func touchUpCell(index: Int)
    func playNewAudio(index: Int)
}

final class Presenter {
    
    private weak var view: IViewController?
    private let formatter = DateComponentsFormatter()
    
    var audioFiles = ["Dabro - На часах ноль-ноль", "Karna.val - Психушка", "NILETTO - Ты такая красивая", "Rauf & Faik, NILETTO - Если тебе будет грустно", "T-killah, Matara - Люби меня люби"]
    
    init(view: IViewController) {
        self.view = view
    }
    
    
}

extension Presenter: IPresenter {
    
    func addAudioInModel(audio: AVAudioPlayer, name: String) {
        ModelStorage.shared.addNewModel(audio: audio, name: name)
    }
    
    func getAudioFromIndex(index: Int) -> AVAudioPlayer {
        ModelStorage.shared.getAudioFromIndex(index: index)
    }
    
    func getCountOfAudio() -> Int {
        return ModelStorage.shared.getCountOfAudio()
    }
    
    func getnameForIndex(index: Int) -> String {
        return ModelStorage.shared.getNameForIndex(index: index)
    }
    
    func getDurationForIndex(index: Int) -> String {
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: ModelStorage.shared.getDurationForIndex(index: index)) ?? ""
    }
    
    func getDurationForIndexDouble(index: Int) -> Double {
        return ModelStorage.shared.getDurationForIndex(index: index)
    }
    
    func stopPlayAllAudio() {
        ModelStorage.shared.stopPlayAllAudio()
    }
    
    func playingAudioCheck(index: Int) -> Bool {
        ModelStorage.shared.playingAudioCheck(index: index)
    }
    
}

extension Presenter {
    
    //подготавливает треки к проигрыванию и вызывает функцию загрузки их в модель
    func viewDidLoad() {
        for audioFile in audioFiles {
            if let path = Bundle.main.path(forResource: audioFile, ofType: "mp3") {
                let url = URL(fileURLWithPath: path)
                do {
                    let audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer.prepareToPlay()
                    addAudioInModel(audio: audioPlayer, name: audioFile)
                } catch {
                    print("Error loading file")
                }
            }
        }
    }
    
    //получили нажатие по ячеке таблицы, нужно включить воспроизведение аудио
      func touchUpCell(index: Int) {
          
          //условие, если выбранная музыка не играет в данный момент и не стоит на паузе
          if playingAudioCheck(index: index) == false && index != ModelStorage.shared.getCurrentAudio(){
              playNewAudio(index: index)
              //если мы открываем мызыку, которая стоит на паузе
          } else {
              getAudioFromIndex(index: index).play()
          }
          // просим VC открыть окно плеера
          view?.openWindowPlayer()
      }
      
      // данная функция завершает проигрывание всех аудио и открывает запрошенное пользователем
      func playNewAudio(index: Int) {
          // сбрасывает всю музыку на ноль, чтобы при повторнм открытии аудио играло с нуля
          stopPlayAllAudio()
          getAudioFromIndex(index: index).play()
      }
}
