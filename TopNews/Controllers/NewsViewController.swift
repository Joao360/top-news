//
//  NewsViewController.swift
//  TopNews
//
//  Created by João Graça on 02/04/2021.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var articles: [Article] = []
    var category: String?
    
    private lazy var mainView = MainView()

    override func loadView() {
        super.loadView()
        
        // Will put view in place and load it
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainView)
        
        mainView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        title = category != nil ? "News for \(category!)" : "News"
        
        mainView.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        mainView.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCellId")
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }

    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    // Default value for cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCellId", for: indexPath) as! NewsTableViewCell
        let article = articles[indexPath.row]
        
        cell.backgroundColor = UIColor.clear
        cell.titleLabel.text = article.title
        cell.dateLabel.text = article.publishedAt
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
