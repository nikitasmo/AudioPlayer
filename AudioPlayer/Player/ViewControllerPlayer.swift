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

protocol vcPlayerTovcMain: AnyObject {
    func getIndexPlayingAudio() -> Int
    func getDurationCurrentAudio(index: Int) -> Double
    func getCurrentTimeOfIndex(index: Int) -> Double
    func getNameForIndex(index: Int) -> String
    func stopPlaying(index: Int)
    func playingCheck(index: Int) -> Bool
    func continuePlay(index: Int)
    func playNextAudio(index: Int)
    func playPreviousAudio(index: Int)
}

final class ViewControllerPlayer: UIViewController {
    
    let formatter = DateComponentsFormatter()
    
    var timer: Timer?
    
    weak var delegate: vcPlayerTovcMain?
    
    var viewPlayer = ViewPlayer()
    
    var currentAudio = Int()
    
    var durationCurrentAudio = Double()
    
    override var shouldAutorotate: Bool {
        return false
    }
    
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
        
        currentAudio = delegate?.getIndexPlayingAudio() ?? 0   //запрашиваем трек, который начал играть
        
        durationCurrentAudio = delegate?.getDurationCurrentAudio(index: currentAudio) ?? 0   //запрашиваем длительность трека
        
        //устанавливаем на лейблы информацию
        viewPlayer.labelDuration.text = formatter.string(from: durationCurrentAudio)
        
        viewPlayer.labelName.text = delegate?.getNameForIndex(index: currentAudio).components(separatedBy: " - ")[1]
        
        viewPlayer.labelAuthor.text = delegate?.getNameForIndex(index: currentAudio).components(separatedBy: " - ")[0]
        
        //запускаем таймер для обновления progressView
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
        
    }

}

//MARK: -viewPlayerToVc
extension ViewControllerPlayer: viewPlayerToVc {
    func buttonBackwardPressed() {  //выызвается при нажатии кнопки "предыдущее аудио"
        delegate?.playPreviousAudio(index: currentAudio)
        initialization()
    }
    
    func buttonForwardPressed() {  //вызывается при нажатии кнопки "следующее аудио"
        delegate?.playNextAudio(index: currentAudio)
        initialization()
    }
    
    func buttonPlayPressed() { //вызываетс при нажатии кнопки play
        if delegate?.playingCheck(index: currentAudio) == true { //выполняется в случае, если музыка играет сейчас
            delegate?.stopPlaying(index: currentAudio)
            viewPlayer.buttonPlay.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {                                                //выполняется если сузыка стоит на паузе
            delegate?.continuePlay(index: currentAudio)
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
        viewPlayer.progresView.progress = Float((delegate?.getCurrentTimeOfIndex(index: currentAudio) ?? 0)/durationCurrentAudio) //вычисляем новое значение для progressView
        //настраиваем форматтер для правильного отображения времени
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        //устанавливаем текущее время музыки
        viewPlayer.labelCurrentTime.text = formatter.string(from: TimeInterval(delegate?.getCurrentTimeOfIndex(index: currentAudio) ?? 0))
        
        //если текущая музыка не играет и не стоит на паузе, включаем следующий трек
        if delegate?.playingCheck(index: currentAudio) == false && delegate?.getCurrentTimeOfIndex(index: currentAudio) == 0 {
            delegate?.playNextAudio(index: currentAudio)
            initialization()
        }
        
    }
}
