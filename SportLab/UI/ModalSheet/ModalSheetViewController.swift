//
//  ModalSheetViewController.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 17.01.2023.
//

import UIKit

class ModalSheetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .yellow
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Сохранить", style: .plain, target: self, action: #selector(didTapRightBarButton))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Назад", style: .plain, target: self, action: #selector(didTapLeftBarButton))
    }
    
    @objc private func didTapRightBarButton() {
        print("Saved!")
    }
    
    @objc private func didTapLeftBarButton() {
        self.dismiss(animated: true)
    }
    
}
