//
//  ViewControllerPlayer.swift
//  AudioPlayer
//
//  Created by Никита on 24/05/2023.
//  Copyright © 2023 com.example. All rights reserved.
//

import UIKit

protocol IViewControllerPlay: AnyObject {
    func setImageButtonPlayToPause()
    func setImageButtonPlayToPlay()
    func setLabel(labelDuration: String, labelName: String, labelAuthor: String)
    func updateProgressView(value: Float)
    func updateLabelCurrentTime(value: String)
    func changeSelectRow(index: Int)
}

protocol ViewControllerPlayerDelegate: AnyObject {
    func changeSelectRow(index: Int)
}

final class ViewControllerPlayer: UIViewController {
    
    let formatter = DateComponentsFormatter()
    
    weak var delegate: ViewControllerPlayerDelegate?
    
    var viewPlayer = ViewPlayer()
    
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
        
        presenterPlayer.viewWillAppear()
        
    }

}

//MARK: - IVewControllerPlay
extension ViewControllerPlayer: IViewControllerPlay {
    func changeSelectRow(index: Int) {
        delegate?.changeSelectRow(index: index)
    }
    
    
    func updateLabelCurrentTime(value: String) {
        viewPlayer.labelCurrentTime.text = value
    }
    
    
    func updateProgressView(value: Float) {
        viewPlayer.progresView.progress = value
    }
    
    //меняем иконку кнопки на "пауза"
    func setImageButtonPlayToPause() {
        viewPlayer.buttonPlay.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    
    //меняем иконку кнопки на "плей"
    func setImageButtonPlayToPlay() {
        viewPlayer.buttonPlay.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    //устанавливаем на лейблы информацию
    func setLabel(labelDuration: String, labelName: String, labelAuthor: String) {
        viewPlayer.labelDuration.text = labelDuration
        
        viewPlayer.labelName.text = labelName
        
        viewPlayer.labelAuthor.text = labelAuthor
    }

}

//MARK: -viewPlayerDelegate
extension ViewControllerPlayer: viewPlayerDelegate {
    func buttonBackwardPressed() {  //выызвается при нажатии кнопки "предыдущее аудио"
        presenterPlayer.playPreviousAudio(index: ModelStorage.shared.getCurrentAudio())
    }
    
    func buttonForwardPressed() {  //вызывается при нажатии кнопки "следующее аудио"
        presenterPlayer.playNextAudio(index: ModelStorage.shared.getCurrentAudio())
    }
    
    func buttonPlayPressed() { //вызываетс при нажатии кнопки play
        presenterPlayer.buttonPlyaPressed()
    }
    
    func buttonClosePressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

