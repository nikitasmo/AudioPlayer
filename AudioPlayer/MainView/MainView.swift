//
//  MainView.swift
//  AudioPlayer
//
//  Created by Никита on 24/05/2023.
//  Copyright © 2023 com.example. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    //MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        MainTableView.delegate = self
        MainTableView.dataSource = self
        
        self.addSubview(MainTableView)
        
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Subviews
    
    var MainTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
}


    //MARK: - UITableViewDelegate
extension MainView: UITableViewDelegate {
    
}

    //MARK: - UITableViewDataSource
extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MainTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}

    //MARK: - Private

extension MainView {
    
    private func configureConstraint() {
        
        MainTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        MainTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        MainTableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        MainTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
}
