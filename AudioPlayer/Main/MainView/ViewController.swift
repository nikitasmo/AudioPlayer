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
    func openWindowPlayer()
}

final class ViewController: UIViewController {
    
    var vcPlayer = ViewControllerPlayer()
    
    let mainView = MainView()
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    //MARK: - Dependency
    private lazy var presenter: IPresenter = {
        return Presenter(view: self)
    }()

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.delegate = self
        vcPlayer.delegate = self
        
        view = mainView
        
        presenter.viewDidLoad()
        
    }

}

//MARK: - IViewController
extension ViewController: IViewController {
    
    func openWindowPlayer() {
        self.present(vcPlayer, animated: true, completion: nil)
    }
    
}

//MARK: - MainViewDelegate
extension ViewController: MainViewDelegate {
    
    func touchUpCell(index: Int) {  // зпускает проигрывание музыки
        presenter.touchUpCell(index: index)
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
extension ViewController: ViewControllerPlayerDelegate {
    func changeSelectRow(index: Int) {
        mainView.MainTableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .bottom)
    }
}
