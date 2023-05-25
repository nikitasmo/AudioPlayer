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
}

extension ViewPlayer {
    
    func configConstraint() {
        buttonClose.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        buttonClose.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonClose.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        buttonPlay.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        buttonPlay.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -200).isActive = true
    }
    
    @objc func touchCloseButton() {
        delegate?.buttonClosePressed()
    }
    
    @objc func buttonPlayPressed() {
        delegate?.buttonPlayPressed()
    }
    
}


