//
//  CategoryTableViewCell.swift
//  TopNews
//
//  Created by João Graça on 30/03/2021.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    lazy var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Some Text"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        cellView.addSubview(label)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            label.heightAnchor.constraint(equalToConstant: 200),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
