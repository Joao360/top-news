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
    
    func loadView() {
        self.backgroundColor = .white
        self.addSubview(tableView)
        setupLayout()
    }
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeTopAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: self.safeBottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.safeLeftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.safeRightAnchor)
        ])
        
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "cellId")
    }
}
