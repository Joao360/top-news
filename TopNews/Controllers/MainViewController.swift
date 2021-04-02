//
//  MainViewController.swift
//  TopNews
//
//  Created by João Graça on 29/03/2021.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Controller's view
    private lazy var mainView = MainView()
    // Loading View Controller to show a loader that blocks any user interaction
    private lazy var loadingViewController: LoadingViewController = {
        let vc = LoadingViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        return vc
    }()
    
    override func loadView() {
        super.loadView()
        
        // Will put view in place and load it
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainView)
        
        mainView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        title = "Categories"
        
        mainView.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        mainView.tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "cellId")
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    // MARK: - TableView
    
    // Use the DEFAULT_CATEGORIES as the table's content
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DEFAULT_CATEGORIES.count
    }
    
    // Fill cell with the category's name
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CategoryTableViewCell
        cell.backgroundColor = UIColor.clear
        cell.label.text = DEFAULT_CATEGORIES[indexPath.row].name
        return cell
    }
    
    // Default value for cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // It will fetch the data for that category and navigate to a new screen to display the info
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        present(loadingViewController, animated: true, completion: nil)
        
        let category: Category = DEFAULT_CATEGORIES[indexPath.row]
        let apiService = APIService()
        apiService.fetchTopHeadlinesFor(category: category.apiParameter, page: 1) { [weak self] (error, articles)  in
            
            DispatchQueue.main.async {
                self?.loadingViewController.dismiss(animated: true) {
                    if let articles = articles {
                        let newsVC = NewsViewController()
                        newsVC.articles = articles
                        newsVC.category = category.name
                        newsVC.fetchNewArticles = { completionHandler in
                            apiService.fetchTopHeadlinesFor(category: category.apiParameter, page: 1, completionHandler: completionHandler)
                        }
                        
                        self?.navigationController?.pushViewController(newsVC, animated: true)
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
    }
}

