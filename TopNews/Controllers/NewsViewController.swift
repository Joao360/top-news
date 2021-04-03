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
    private var isFetching = false
    private var currentPage = 1
    private let apiService = APIService()
    
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
        mainView.tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: "loadingCell")
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
        apiService.fetchDataFrom(url: URL(string: url)!) { error, data in
            if let error = error {
                print("Error fetching image with url \(url). Error: \(error)")
                return
            }
            
            if let data = data {
                let img = UIImage(data: data)
                DispatchQueue.main.async {
                    cell.articleImage.image = img
                }
            }
        }
    }
    
    private func fetchNextPage() {
        guard let category = category, isFetching == false else { return }
        isFetching = true
        currentPage += 1
        print("Fetching page number \(currentPage)")
        self.mainView.tableView.reloadData()
        apiService.fetchTopHeadlinesFor(category: category, page: currentPage) { [weak self] error, articles in
            self?.isFetching = false
            
            if let error = error {
                print("Error fetching next page: \(error)")
                
                // Correct page number to retry it on the next fetch
                self?.currentPage -= 1
                return
            }
            
            if let articles = articles {
                self?.articles.append(contentsOf: articles)
            }
            
            DispatchQueue.main.async {
                self?.mainView.tableView.reloadData()
            }
        }
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count + (isFetching ? 1 : 0)
    }
    
    // Default value for cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableViewCell: UITableViewCell!
        
        if indexPath.row < articles.count {
            // It's an article cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsCellId", for: indexPath) as! NewsTableViewCell
            let article = articles[indexPath.row]
            
            cell.articleImage.image = UIImage(named: "default")
            cell.backgroundColor = UIColor.clear
            cell.titleLabel.text = article.title
            cell.dateLabel.text = article.publishedAt
            
            if let url = article.urlToImage {
                fetchArticleImage(url, cell)
            }
            
            tableViewCell = cell
        } else if indexPath.row == articles.count {
            // It's the loading cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingTableViewCell
            cell.loadingActivityIndicator.startAnimating()
            tableViewCell = cell
        }
        
        // Reached last element, load next page if it's not fetching already
        if indexPath.row == articles.count - 1 && !isFetching {
            fetchNextPage()
        }
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        
        let webvc = WebViewController()
        webvc.url = article.url
        
        self.navigationController?.pushViewController(webvc, animated: true)
    }
}
