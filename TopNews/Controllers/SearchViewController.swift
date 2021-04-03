//
//  SearchViewController.swift
//  TopNews
//
//  Created by João Graça on 03/04/2021.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, NewsDelegate {
    private lazy var searchView: SearchView = SearchView()
    private lazy var newsVC: NewsViewController = {
        let vc = NewsViewController()
        vc.delegate = self
        return vc
    }()
    
    private var currentRequest: URLSessionDataTask?
    private var currentQuery: String?
    private let apiService = APIService()
    
    override func loadView() {
        super.loadView()
        
        addChild(newsVC)
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        newsVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchView)
        view.addSubview(newsVC.view)
        
        setupLayout()
        
        searchView.loadView()
        
        title = "Search"
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 80),
            
            newsVC.view.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            newsVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchView.searchTextField.delegate = self
    }
    
    @objc private func fetchArticles(_ sender: Any) {
        guard let query = searchView.searchTextField.text else { return }
        currentQuery = query
        currentRequest = apiService.fetchEverything(query: query, page: 1) { [weak self] error, articles in
            if let error = error {
                let alert = UIAlertController(title: "Something went wrong", message: error, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
                    alert.dismiss(animated: true)
                })
                
                self?.present(alert, animated: true, completion: nil)
                return
            }
            
            guard let articles = articles else { return }
            
            DispatchQueue.main.async {
                self?.articles = articles
                self?.newsVC.mainView.tableView.reloadData()
            }
        }
    }
    
    // MARK: - TextField
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        currentRequest?.cancel()
        perform(#selector(fetchArticles(_:)), with: self, afterDelay: 0.5)
        return true
    }

    // MARK: - NewsDelegate
    var articles: [Article] = []
    
    var category: Category?
    
    func fetchArticles(page: Int, completionHandler: @escaping (String?, [Article]?) -> Void) {
        guard let query = currentQuery else {
            completionHandler(nil, nil)
            return
        }
        let _ = apiService.fetchEverything(query: query, page: page, completionHandler: completionHandler)
    }
}
