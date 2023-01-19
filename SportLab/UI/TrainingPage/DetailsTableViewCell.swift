//
//  DetailsTableViewCell.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 17.01.2023.
//


import UIKit

class DetailsTableViewCell: UITableViewCell {
    static let identifier = "DetailsTableViewCell"
    
    private let exNameLabel = UILabel()
    private let recordLabel = UILabel()
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
        contentView.addSubview(exNameLabel)
        contentView.addSubview(recordLabel)
    }
    
    private func setupSubviews() {
        exImageView.translatesAutoresizingMaskIntoConstraints = false
        
        exNameLabel.translatesAutoresizingMaskIntoConstraints = false
        exNameLabel.numberOfLines = 0
        exNameLabel.textAlignment = .center
        
        recordLabel.translatesAutoresizingMaskIntoConstraints = false
        recordLabel.numberOfLines = 0
        recordLabel.textAlignment = .center
        
    }
    
    private func setupConstraints() {
        let constraints = [
            exImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            exImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            exImageView.widthAnchor.constraint(equalToConstant: 64),
            exImageView.heightAnchor.constraint(equalTo: exImageView.widthAnchor),
            
            exNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            exNameLabel.leftAnchor.constraint(equalTo: exImageView.rightAnchor, constant: 24),
            exNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            exNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            recordLabel.topAnchor.constraint(equalTo: exNameLabel.bottomAnchor),
            recordLabel.leftAnchor.constraint(equalTo: exNameLabel.leftAnchor),
            recordLabel.rightAnchor.constraint(equalTo: exNameLabel.rightAnchor),
            recordLabel.heightAnchor.constraint(equalTo: exNameLabel.heightAnchor),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }

    override func prepareForReuse() {
        exNameLabel.text = ""
        recordLabel.text = ""
        exImageView.image = nil
    }
    
    func configure(with exercise: Exercise) {
        exNameLabel.text = exercise.name
        recordLabel.text = "Текущий вес: " + "\(exercise.record)" + " кг"
        exImageView.image = UIImage(named: exercise.imageName)
    }
}

