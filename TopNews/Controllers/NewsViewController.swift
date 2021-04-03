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
    var fetchNewArticles: (@escaping (String?, [Article]?) -> Void) -> Void = { completionHandler in completionHandler(nil, nil) }
    
    private lazy var mainView = MainView()
    private lazy var refreshControl = UIRefreshControl()

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
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            mainView.tableView.refreshControl = refreshControl
        } else {
            mainView.tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching New Data ...")
    }
    
    @objc private func refreshData(_ sender: Any) {
        // Fetch Weather Data
        fetchNewArticles { [weak self] (error, articles) in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                
                if let articles = articles {
                    self?.articles = articles
                } else if let error = error {
                    let alert = UIAlertController(title: "Something went wrong", message: error, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
                        alert.dismiss(animated: true)
                    })
                    
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    fileprivate func fetchArticleImage(_ url: String, _ cell: NewsTableViewCell) {
        APIService().fetchDataFrom(url: URL(string: url)!) { error, data in
            var img = UIImage(named: "default")
            
            if let error = error {
                print("Error fetching image with url \(url). Error: \(error)")
            } else if let data = data {
                img = UIImage(data: data)
            }
            
            DispatchQueue.main.async {
                cell.articleImage.image = img
            }
        }
    }

    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    // Default value for cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCellId", for: indexPath) as! NewsTableViewCell
        let article = articles[indexPath.row]
        
        cell.backgroundColor = UIColor.clear
        cell.titleLabel.text = article.title
        cell.dateLabel.text = article.publishedAt
        
        if let url = article.urlToImage {
            fetchArticleImage(url, cell)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        
        let webvc = WebViewController()
        webvc.url = article.url
        
        self.navigationController?.pushViewController(webvc, animated: true)
    }
}
