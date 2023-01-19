//
//  GoalsViewController.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 10.01.2023.
//
//  Достижения столбцом с наивысшими показателями.

import UIKit
import CoreData

extension GoalsViewController: ResourceLoaderProvider {
    var resourceLoader: ResourceLoader {
        return ResourceLoader.shared
    }
}

class GoalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    let noGoalsLabel = UILabel()
    var tableView = UITableView()
    var sections = [MuscleGroup]()
    var frc: NSFetchedResultsController<MOGoal>!
    
    override func viewWillAppear(_ animated: Bool) {
        checkGoals()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFRC()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    private func setupFRC() {
        frc = CoreDataManager.shared.createGoalFRC()
        frc.delegate = self
        try? frc.performFetch()
        
     
    }
    
    private func checkGoals() {
        if let fetchedGoals = frc.fetchedObjects, !fetchedGoals.isEmpty {
            setupSections()
            setupGoalsTableView()
        } else {
            setupNoGoalsLabel()
        }
    }
    
    private func setupGoalsTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.rowHeight = 136
        tableView.register(GoalsTableViewCell.self, forCellReuseIdentifier: GoalsTableViewCell.identifier)
    }
    
    private func setupNoGoalsLabel() {
        view.addSubview(noGoalsLabel)
        
        noGoalsLabel.text = "Доска достижений пуста."
        noGoalsLabel.textColor = .secondaryLabel
        noGoalsLabel.textAlignment = .center
        noGoalsLabel.frame = CGRect(x: 0, y: 0, width: 400, height: 200)
        noGoalsLabel.center = view.center
    }
    
    private func setupSections() {
        var sSet: Set<MuscleGroup> = []
        guard let moGoals = frc.fetchedObjects else {
            return
        }
        let goals = moGoals.map({ Goal(from: $0) })
        for goal in goals {
            if let muscleGroup = MuscleGroup.allCases.filter({ $0 == goal.exercise.group }).first {
                sSet.insert(muscleGroup)
            }
        }
        sections = Array(sSet).sorted(by: {$0.title < $1.title})
    }
    
    //MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let goals = frc.sections?[section] else {
            return 0
        }
        return goals.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GoalsTableViewCell.identifier, for: indexPath) as? GoalsTableViewCell else {
            return UITableViewCell()
        }
        let goal = Goal(from: frc.object(at: indexPath))
        cell.configure(with: goal)
        return cell
    }
    
    
    //MARK: - FRC Methods
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .move:
            guard let newIndexPath = newIndexPath, let indexPath = indexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        default:
            tableView.reloadData()
        }
    }
}
