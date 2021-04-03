//
//  LoadingTableViewCell.swift
//  TopNews
//
//  Created by João Graça on 03/04/2021.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    lazy var cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.isHidden = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(loadingActivityIndicator)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            loadingActivityIndicator.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            loadingActivityIndicator.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
        ])
    }

}
