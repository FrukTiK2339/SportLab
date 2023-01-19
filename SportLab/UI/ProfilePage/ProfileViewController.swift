//
//  ProfileViewController.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 10.01.2023.
//
//  Профиль пользователя (имя, вес, желаемый вес, календарь тренировок)

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapBarButton))
    }
    
    @objc private func didTapBarButton() {
        let vc = SettingsViewController()
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        self.navigationItem.backBarButtonItem = backButton
        navigationController?.pushViewController(vc, animated: true)
    }
}
