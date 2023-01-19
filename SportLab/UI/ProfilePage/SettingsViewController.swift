//
//  SettingsViewController.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 10.01.2023.
//
//  Редактировать профиль, просмотр условий пользования(ссылки), сброс статистики достижений.

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Сохранить", style: .plain, target: self, action: #selector(didTapBarButton))
//    }
//
//    @objc private func didTapBarButton() {
//        self.navigationController?.popToRootViewController(animated: true)
//    }
}
