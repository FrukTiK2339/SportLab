//
//  DetailsViewController.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 10.01.2023.
//
//  Просмотр выбранной тренировки

import UIKit
import CoreData

protocol DetailsModalSheetDelegate: AnyObject {
    func updateRecord(with value: Int, for exercise: Exercise?)
}

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {
    
    var training: Training?
    let tableView = UITableView()
    var sections = [MuscleGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRightBarButton()
        setupUI()
        setupSections()
        setupTableView()
    }
    
    private func setupRightBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Сохранить", style: .plain, target: self, action: #selector(didTapBarButton))
        self.navigationItem.rightBarButtonItem?.isHidden = true
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    private func setupSections() {
        var sSet: Set<MuscleGroup> = []
        guard let exercises = training?.exercises else {
            return
        }
        for exercise in exercises {
            sSet.insert(exercise.group)
        }
        sections = Array(sSet).sorted(by: {$0.title < $1.title})
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.identifier)
        tableView.rowHeight = 104
        tableView.backgroundColor = .white
    }
    
    @objc private func didTapBarButton() {
        
    }
    
    
    //MARK: - TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return training?.exercises.filter{ $0.group == sections[section] }.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifier, for: indexPath) as? DetailsTableViewCell,
              let model = training?.exercises.filter({ $0.group == sections[indexPath.section] })[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ///Выбрал элемент (indexPath)
        guard let model = training?.exercises.filter({ $0.group == sections[indexPath.section] })[indexPath.row] else {
            return
        }
        ///Открыл мини view с выбором числа
        let vc = DetailsModalSheetViewController()
        vc.exercise = model
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 20
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
        }
        
        present(nav, animated: true)
    }
}

extension DetailsViewController: DetailsModalSheetDelegate {
    func updateRecord(with value: Int, for exercise: Exercise?) {
        guard var exercise = exercise, let uniqueID = exercise.uniqueID else { return }
        CoreDataManager.shared.setExercise(newRecordValue: value, by: uniqueID) 
        
        if value > 0 {
            CoreDataManager.shared.createGoal(with: value, for: exercise)
        }
        
        if var exercises = training?.exercises {
            exercises = exercises.filter({ $0.name != exercise.name})
            exercise.record = value
            exercises.append(exercise)
            training?.exercises = exercises.sorted(by: {$0.name < $1.name })
        }
        tableView.reloadData()
    }
}





