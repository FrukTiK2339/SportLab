//
//  TrainingPageViewController.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 10.01.2023.
//
//  Просмотр всех тренировок списком

import UIKit
import CoreData

extension TrainingPageViewController: ResourceLoaderProvider {
    var resourceLoader: ResourceLoader {
        return ResourceLoader.shared
    }
}

class TrainingPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    var fetchedResultsController: NSFetchedResultsController<MOTraining>!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        setupFetchedResultConroller()
        setupUI()
        setupTableView()
    }
    
    func setupFetchedResultConroller() {
        fetchedResultsController = CoreDataManager.shared.createTrainingFetchedResultController()
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapBarButton))
    }
    
    @objc private func didTapBarButton() {
        let vc = ConstructorViewController()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Мои тренировки", style: .plain, target: vc, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrainingPageTableViewCell.self, forCellReuseIdentifier: TrainingPageTableViewCell.identifier)
        tableView.rowHeight = 60
    }
    
    //MARK: - TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let training = fetchedResultsController.sections?[section] else {
            return 0
        }
        return training.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrainingPageTableViewCell.identifier, for: indexPath) as? TrainingPageTableViewCell else {
            return UITableViewCell()
        }
        let training = fetchedResultsController.object(at: indexPath)
        cell.configure(with: training)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteTraining = UIContextualAction(style: .destructive, title: "") { (_, _, completion) in
            let training = self.fetchedResultsController.object(at: indexPath)
            CoreDataManager.shared.delete(moTraining: training)
            completion(true)
        }
        deleteTraining.image = UIImage(systemName: "trash")
        let configuration = UISwipeActionsConfiguration(actions: [deleteTraining])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        vc.training = Training(from: fetchedResultsController.object(at: indexPath))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Мои тренировки", style: .plain, target: vc, action: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
    //MARK: - NSFetchedResultController
extension TrainingPageViewController: NSFetchedResultsControllerDelegate {
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
