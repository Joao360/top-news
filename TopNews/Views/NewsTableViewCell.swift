//
//  NewsTableViewCell.swift
//  TopNews
//
//  Created by João Graça on 02/04/2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    lazy var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Here stands the title, first of its name"
        label.numberOfLines = 2
        label.sizeToFit()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Here stands the date, first of its name"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 12)
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
        cellView.addSubview(titleLabel)
        cellView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -8),
            
            dateLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8),
            dateLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8),
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
