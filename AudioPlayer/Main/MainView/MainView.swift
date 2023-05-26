//
//  MainView.swift
//  AudioPlayer
//
//  Created by Никита on 24/05/2023.
//  Copyright © 2023 com.example. All rights reserved.
//

import UIKit

protocol MainViewDelegate: AnyObject {
    func getCountAudio() -> Int
    func getNameForIndex(index: Int) -> String
    func getDurationForIndex(index: Int) -> String
    func touchUpCell(index: Int)
}

final class MainView: UIView {
    
    weak var delegate: MainViewDelegate?
    
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
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
}


    //MARK: - UITableViewDelegate
extension MainView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.touchUpCell(index: indexPath.row)
    }
}

    //MARK: - UITableViewDataSource
extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.getCountAudio() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MainTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        generateCell(cell: cell, index: indexPath.row)
        
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
    
    private func generateCell(cell: UITableViewCell, index: Int) {
        let viewCell = UIView()
        viewCell.translatesAutoresizingMaskIntoConstraints = false
        
        let labelName = UILabel()
        labelName.text = delegate?.getNameForIndex(index: index)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        
        let labelDuration = UILabel()
        labelDuration.text = delegate?.getDurationForIndex(index: index)
        labelDuration.textAlignment = .right
        labelDuration.translatesAutoresizingMaskIntoConstraints = false
        
        cell.contentView.addSubview(viewCell)
        viewCell.addSubview(labelName)
        viewCell.addSubview(labelDuration)
        
        viewCell.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
        viewCell.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
        viewCell.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        viewCell.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        
        labelName.leadingAnchor.constraint(equalTo: viewCell.leadingAnchor, constant: 20).isActive = true
        labelName.centerYAnchor.constraint(equalTo: viewCell.centerYAnchor).isActive = true
        labelName.widthAnchor.constraint(equalTo: viewCell.widthAnchor, multiplier: 2/3).isActive = true
        
        labelDuration.leadingAnchor.constraint(equalTo: labelName.trailingAnchor).isActive = true
        labelDuration.trailingAnchor.constraint(equalTo: viewCell.trailingAnchor, constant: -20).isActive = true
        labelDuration.centerYAnchor.constraint(equalTo: viewCell.centerYAnchor).isActive = true
        
    }
    
}
