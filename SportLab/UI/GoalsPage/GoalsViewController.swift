//
//  GoalsViewController.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 10.01.2023.
//
//  Достижения столбцом с наивысшими показателями.

import UIKit

extension GoalsViewController: ResourceLoaderProvider {
    var resourceLoader: ResourceLoader {
        return ResourceLoader.shared
    }
}

class GoalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let noGoalsLabel = UILabel()
    var tableView = UITableView()
    var sections = MuscleGroup.allCases
    var goals = [Goal]()
    
    override func viewWillAppear(_ animated: Bool) {
        loadUserGoals()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func loadUserGoals() {
        if let goals = resourceLoader.userData?.goals, !goals.isEmpty {
            setupGoalsTableView()
            self.goals = goals
        } else {
            setupNoGoalsLabel()
        }
    }
    
    private func setupGoalsTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupNoGoalsLabel() {
        view.addSubview(noGoalsLabel)
        
        noGoalsLabel.text = "Доска достижений пуста."
        noGoalsLabel.textColor = .secondaryLabel
        noGoalsLabel.textAlignment = .center
        noGoalsLabel.frame = CGRect(x: 0, y: 0, width: 400, height: 200)
        noGoalsLabel.center = view.center
    }
    
    //MARK: - TableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.filter{ $0.exercise.group == sections[section] }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
}
