//
//  ConstructorViewController.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 10.01.2023.
//
//  Конструктор тренировок

import UIKit

extension ConstructorViewController: ResourceLoaderProvider {
    var resourceLoader: ResourceLoader {
        return ResourceLoader.shared
    }
}

class ConstructorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var exercises = [Exercise]()
    var textField = UITextField()
    var tableView = UITableView()
    var sections = MuscleGroup.allCases
    var selectedExercises = [Exercise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadExercises()
    }
    
    private func setupUI() {
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(tableView)
        view.addSubview(textField)
        
        
        setupRightBarButton()
        setupTableView()
        setupTextField()
        setupConstraints()
    }
    
    private func setupRightBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Сохранить", style: .plain, target: self, action: #selector(didTapBarButton))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func loadExercises() {
        guard let exercises = resourceLoader.exercises else {
            DLog("Error! No basic exercises have been loaded.")
            return
        }
        DLog(exercises.count)
        self.exercises = exercises
    }
    
    @objc private func didTapBarButton() {
        //Check
        guard let newTrainingName = textField.text, !newTrainingName.isEmpty else {
            textField.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        //Save new Training
        let newTraining = Training(title: newTrainingName, exercises: selectedExercises)
        resourceLoader.save(userTraining: newTraining)
        
        //Dismiss VC
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let contraints = [
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(contraints)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .secondarySystemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupTextField() {
        textField.delegate = self
        textField.placeholder = "Название тренировки..."
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8.0
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.gray.cgColor
    }
    
    //MARK: - TextField Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.placeholder = "Название тренировки..."
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    //MARK: - TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.filter{ $0.group == sections[section] }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Упражение №\(indexPath.row)"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        textField.endEditing(true)
        let checkedExercise = exercises.filter{ $0.group == sections[indexPath.section] }[indexPath.row]
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType != .checkmark {
                cell.accessoryType = .checkmark
                selectedExercises.append(checkedExercise)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            } else {
                cell.accessoryType = .none
                selectedExercises = selectedExercises.filter{ $0.name != checkedExercise.name }
                if selectedExercises.isEmpty {
                    self.navigationItem.rightBarButtonItem?.isEnabled = false
                }
            }
        }
        
        
        
    }
    
}
