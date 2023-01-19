//
//  ConstructorTableViewCell.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 12.01.2023.
//

import UIKit

class ConstructorTableViewCell: UITableViewCell {
    
    static let identifier = "ConstructorTableViewCell"
    
    private let titleLabel = UILabel()
    private let exImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews()
        setupSubviews()
        setupConstraints()
        
        self.selectionStyle = .none
    }
    
    private func addSubviews() {
        contentView.addSubview(exImageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupSubviews() {
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        exImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        let constraints = [
            exImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            exImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            exImageView.widthAnchor.constraint(equalToConstant: 64),
            exImageView.heightAnchor.constraint(equalTo: exImageView.widthAnchor),
            
            
            titleLabel.topAnchor.constraint(equalTo: exImageView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: exImageView.rightAnchor, constant: 24),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            titleLabel.heightAnchor.constraint(equalToConstant: 24)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
  
    
    override func prepareForReuse() {
        titleLabel.text = ""
        exImageView.image = nil
    }
    
    func configure(with exercise: Exercise) {
        titleLabel.text = exercise.name
        exImageView.image = UIImage(named: exercise.imageName)
    }
}
