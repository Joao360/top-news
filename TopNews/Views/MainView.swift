//
//  MainView.swift
//  TopNews
//
//  Created by João Graça on 02/04/2021.
//

import Foundation
import UIKit

class MainView: UIView {
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func loadView() {
        self.backgroundColor = .white
        self.addSubview(titleLabel)
        self.addSubview(tableView)
        setupLayout()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeTopAnchor),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: self.safeBottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.safeLeftAnchor),
            tableView.safeRightAnchor.constraint(equalTo: self.safeRightAnchor)
        ])
        
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "cellId")
    }
}
