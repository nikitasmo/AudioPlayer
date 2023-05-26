//
//  ViewControllerPlayer.swift
//  AudioPlayer
//
//  Created by Никита on 24/05/2023.
//  Copyright © 2023 com.example. All rights reserved.
//

import UIKit

protocol IViewControllerPlay: AnyObject {
    func initialization()
}

protocol ViewControllerPlayerDelegate: AnyObject {
   
}

final class ViewControllerPlayer: UIViewController {
    
    let formatter = DateComponentsFormatter()
    
    var timer: Timer?
    
    weak var delegate: ViewControllerPlayerDelegate?
    
    var viewPlayer = ViewPlayer()
    
    var durationCurrentAudio = Double()
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    lazy var presenterPlayer: IPresenterPlayer = {
       return PresenterPlayer(view: self)
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewPlayer.delegate = self

        view = viewPlayer
        
        view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        initialization()  //каждый раз при открытии окна плеера выполняем ряд действий
        
    }

}

//MARK: - IVewControllerPlay
extension ViewControllerPlayer: IViewControllerPlay {
    
    
    
    func initialization() {
        
        viewPlayer.buttonPlay.setImage(UIImage(systemName: "pause.fill"), for: .normal)  //меняем иконку кнопки на "пауза"
        
//        currentAudio = presenterPlayer.getIndexPlayingAudio()   //запрашиваем трек, который начал играть
        ModelStorage.shared.setCurrentAudio(index: presenterPlayer.getIndexPlayingAudio())
        
        durationCurrentAudio = presenterPlayer.getDurationCurrentAudioDouble(index: ModelStorage.shared.getCurrentAudio())   //запрашиваем длительность трека
        
        //устанавливаем на лейблы информацию
        viewPlayer.labelDuration.text = formatter.string(from: durationCurrentAudio)
        
        viewPlayer.labelName.text = presenterPlayer.getNameForIndex(index: ModelStorage.shared.getCurrentAudio()).components(separatedBy: " - ")[1]
        
        viewPlayer.labelAuthor.text = presenterPlayer.getNameForIndex(index: ModelStorage.shared.getCurrentAudio()).components(separatedBy: " - ")[0]
        
        //запускаем таймер для обновления progressView
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
        
    }

}

//MARK: -viewPlayerDelegate
extension ViewControllerPlayer: viewPlayerDelegate {
    func buttonBackwardPressed() {  //выызвается при нажатии кнопки "предыдущее аудио"
        presenterPlayer.playPreviousAudio(index: ModelStorage.shared.getCurrentAudio())
        initialization()
    }
    
    func buttonForwardPressed() {  //вызывается при нажатии кнопки "следующее аудио"
        presenterPlayer.playNextAudio(index: ModelStorage.shared.getCurrentAudio())
        
        initialization()
    }
    
    func buttonPlayPressed() { //вызываетс при нажатии кнопки play
        if presenterPlayer.playingCheck(index: ModelStorage.shared.getCurrentAudio()) == true { //выполняется в случае, если музыка играет сейчас
            presenterPlayer.stopPlaying(index: ModelStorage.shared.getCurrentAudio())
            viewPlayer.buttonPlay.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {                                                //выполняется если сузыка стоит на паузе
            presenterPlayer.continuePlay(index: ModelStorage.shared.getCurrentAudio())
            viewPlayer.buttonPlay.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    func buttonClosePressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - Selectors
private extension ViewControllerPlayer {
    
    @objc func updateProgressView() { //обновляем progressView
        viewPlayer.progresView.progress = Float((presenterPlayer.getCurrentTimeOfIndex(index: ModelStorage.shared.getCurrentAudio()))/durationCurrentAudio) //вычисляем новое значение для progressView
        //настраиваем форматтер для правильного отображения времени
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        //устанавливаем текущее время музыки
        viewPlayer.labelCurrentTime.text = formatter.string(from: TimeInterval(presenterPlayer.getCurrentTimeOfIndex(index: ModelStorage.shared.getCurrentAudio())))
        
        //если текущая музыка не играет и не стоит на паузе, включаем следующий трек
        if presenterPlayer.playingCheck(index: ModelStorage.shared.getCurrentAudio()) == false && presenterPlayer.getCurrentTimeOfIndex(index: ModelStorage.shared.getCurrentAudio()) == 0 {
            presenterPlayer.playNextAudio(index: ModelStorage.shared.getCurrentAudio())
            initialization()
        }
        
    }
}
