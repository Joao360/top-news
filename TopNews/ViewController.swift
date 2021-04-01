//
//  ViewController.swift
//  TopNews
//
//  Created by João Graça on 29/03/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let categories = ["business", "entertainment",  "general", "health", "science", "sports", "technology"]
    
    let tableView: UITableView = {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTitleLabel()
        setupTableView()
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        } else {
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        }
    }

    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CategoryTableViewCell
        cell.backgroundColor = UIColor.clear
        cell.label.text = categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

