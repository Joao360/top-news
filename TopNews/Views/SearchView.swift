//
//  SearchView.swift
//  TopNews
//
//  Created by João Graça on 03/04/2021.
//

import UIKit

class SearchView: UIView {
    
    lazy var searchTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Search news"
        txt.borderStyle = .roundedRect
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    func loadView() {
        self.addSubview(searchTextField)
        
        self.backgroundColor = .white
        setupLayout()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: self.safeTopAnchor, constant: 16),
            searchTextField.leftAnchor.constraint(equalTo: self.safeLeftAnchor, constant: 8),
            searchTextField.rightAnchor.constraint(equalTo: self.safeRightAnchor, constant: -8),
            searchTextField.bottomAnchor.constraint(equalTo: self.safeBottomAnchor, constant: -16),
        ])
    }
    
}
