//
//  GoalsTableViewCell.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 12.01.2023.
//

import UIKit

class GoalsTableViewCell: UITableViewCell {
    static let identifier = "GoalsCollectionViewCell"
    
    private let exName = UILabel()
    private let exResult = UILabel()
    private let cupImage = UIImageView()
    private let exImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        addSubviews()
        setupSubviews()
        setupNSConstraints()
        self.selectionStyle = .none
    }
    
    private func addSubviews() {
        contentView.addSubview(exImage)
        contentView.addSubview(cupImage)
        contentView.addSubview(exName)
        contentView.addSubview(exResult)
    }
    
    private func setupSubviews() {
        exName.translatesAutoresizingMaskIntoConstraints = false
        exName.numberOfLines = 0
        exName.textAlignment = .center
        
        exResult.textAlignment = .left
        
        exResult.translatesAutoresizingMaskIntoConstraints = false
        cupImage.translatesAutoresizingMaskIntoConstraints = false
        exImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func  setupNSConstraints() {
        let constraints = [
            exImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            exImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            exImage.widthAnchor.constraint(equalToConstant: 120),
            exImage.heightAnchor.constraint(equalTo: exImage.widthAnchor),
            
            exName.topAnchor.constraint(equalTo: exImage.topAnchor),
            exName.leftAnchor.constraint(equalTo: exImage.rightAnchor),
            exName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            exName.heightAnchor.constraint(equalToConstant: 40),
            
            cupImage.topAnchor.constraint(equalTo: exName.bottomAnchor, constant: 8),
            cupImage.centerXAnchor.constraint(equalTo: exName.centerXAnchor),
            cupImage.bottomAnchor.constraint(equalTo: exImage.bottomAnchor),
            cupImage.widthAnchor.constraint(equalTo: cupImage.heightAnchor),
            
            exResult.centerYAnchor.constraint(equalTo: cupImage.centerYAnchor),
            exResult.leftAnchor.constraint(equalTo: cupImage.rightAnchor, constant: 8),
            exResult.rightAnchor.constraint(equalTo: exName.rightAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        exName.text = ""
        exImage.image = nil
        cupImage.image = nil
        exResult.text = ""
    }
    
    func configure(with goal: Goal) {
        exName.text = goal.exercise.name
        exImage.image = UIImage(named: goal.exercise.imageName)
        cupImage.image = UIImage(named: "cupImage")
        exResult.text = "\(goal.record) кг"
    }
    
}
