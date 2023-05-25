//
//  ViewPlayer.swift
//  AudioPlayer
//
//  Created by Никита on 24/05/2023.
//  Copyright © 2023 com.example. All rights reserved.
//

import UIKit

protocol viewPlayerToVc: AnyObject {
    func buttonClosePressed()
    func buttonPlayPressed()
}

class ViewPlayer: UIView {
    
    weak var delegate: viewPlayerToVc?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(buttonClose)
        self.addSubview(buttonPlay)
        self.addSubview(progresView)
        self.addSubview(labelCurrentTime)
        self.addSubview(labelDuration)
        
        configConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var buttonClose: UIButton = {
        var button = UIButton()
        button.setTitle("X Close", for: .normal)
        button.setTitleColor(.blue,for: .normal)
        button.addTarget(self, action: #selector(touchCloseButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var buttonPlay: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.addTarget(self, action: #selector(buttonPlayPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var progresView: UIProgressView = {
        var progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    var labelCurrentTime: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelDuration: UILabel = {
        var label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension ViewPlayer {
    
    func configConstraint() {
        buttonClose.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        buttonClose.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonClose.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        buttonPlay.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        buttonPlay.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -200).isActive = true
        
        progresView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        progresView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        progresView.bottomAnchor.constraint(equalTo: buttonPlay.topAnchor, constant: -10).isActive = true
        progresView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        labelCurrentTime.leadingAnchor.constraint(equalTo: progresView.leadingAnchor).isActive = true
        labelCurrentTime.bottomAnchor.constraint(equalTo: progresView.topAnchor, constant: -20).isActive = true
        labelCurrentTime.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        labelDuration.trailingAnchor.constraint(equalTo: progresView.trailingAnchor).isActive = true
        labelDuration.bottomAnchor.constraint(equalTo: progresView.topAnchor, constant: -20).isActive = true
        labelDuration.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    @objc func touchCloseButton() {
        delegate?.buttonClosePressed()
    }
    
    @objc func buttonPlayPressed() {
        delegate?.buttonPlayPressed()
    }
    
}


