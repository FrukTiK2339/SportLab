//
//  LaunchViewController.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 10.01.2023.
//
//  Запустить все службы, показать HomePage по готовности

import UIKit

class LauncherViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addObservers()
        normalRun()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveData), name: Notification.Name.successLoadingAppData, object: nil)
    }
    
    private func normalRun() {
        resourceLoader.loadAppData()
    }
    
    @objc private func didReceiveData() {
        DispatchQueue.main.async {
            let vc = TabBarController()
            self.navigationController?.setViewControllers([vc], animated:true)
        }
        
    }
    
    @objc private func didReceiveError() {
        //might be useless just now
    }
}
