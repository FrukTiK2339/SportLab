//
//  TrainingPageTableViewCell.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 18.01.2023.
//

import UIKit

class TrainingPageTableViewCell: UITableViewCell {
    static let identifier = "TrainingPageTableViewCell"
    
    private let titleLabel = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        
        self.selectionStyle = .none
        
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        let constraints = [
           
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 24),
            titleLabel.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -24),
            titleLabel.heightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    override func prepareForReuse() {
        titleLabel.text = ""
    }
    
    func configure(with training: MOTraining) {
        titleLabel.text = training.title
    }
}
