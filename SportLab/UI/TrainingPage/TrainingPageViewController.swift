//
//  TrainingPageViewController.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 10.01.2023.
//
//  Просмотр всех тренировок списком

import UIKit

extension TrainingPageViewController: ResourceLoaderProvider {
    var resourceLoader: ResourceLoader {
        return ResourceLoader.shared
    }
}

class TrainingPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var training = [Training]()
    let tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        loadTraining()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        view.backgroundColor = .secondarySystemBackground
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(didTapBarButton))
    }
    
    @objc private func didTapBarButton() {
        let vc = ConstructorViewController()
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        self.navigationItem.backBarButtonItem = backButton
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func loadTraining() {
        resourceLoader.loadTraining()
        if let training = resourceLoader.training {
            self.training = training
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.backgroundColor = .secondarySystemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    //MARK: - TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return training.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .gray
        return cell
    }
    
}
