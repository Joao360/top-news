//
//  MainViewController.swift
//  TopNews
//
//  Created by João Graça on 29/03/2021.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private lazy var mainView = MainView()
    private lazy var loadingViewController: LoadingViewController = {
        let vc = LoadingViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        return vc
    }()
    
    override func loadView() {
        super.loadView()
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainView)
        
        mainView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        mainView.titleLabel.text = "Categories"
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DEFAULT_CATEGORIES.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CategoryTableViewCell
        cell.backgroundColor = UIColor.clear
        cell.label.text = DEFAULT_CATEGORIES[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        present(loadingViewController, animated: true, completion: nil)
        
        APIService().fetchTopHeadlinesFor(category: DEFAULT_CATEGORIES[indexPath.row].apiParameter, page: 1) { [weak self] (error, articles)  in
            
            print("ERROR: \(error ?? "None")")
            print("ARTICLES: \(articles ?? [])")
            
            DispatchQueue.main.async {
                self?.loadingViewController.dismiss(animated: true, completion: nil)
            }
        }
    }
}

