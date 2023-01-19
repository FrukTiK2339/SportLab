//
//  DetailsModalSheetViewController.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 18.01.2023.
//

import UIKit

class DetailsModalSheetViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate: DetailsModalSheetDelegate?
    var exercise: Exercise?
    private var selectedValue = Int()
    
    private let exImageView = UIImageView()
    private let recordLabel = UILabel()
    private let exNameLabel = UILabel()
    
    
    private let pickerView = UIPickerView()
    private var pickerData: [[Any]] = {
        var mArray = [[Any]]()
        var array = [String]()
        for int in 0...100 {
            let newElement = "\(int) кг"
            array.append(newElement)
        }
        mArray.append(array)
        return mArray
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Сохранить", style: .plain, target: self, action: #selector(didTapRightBarButton))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Назад", style: .plain, target: self, action: #selector(didTapLeftBarButton))

        
        setupSubviews()
        setupConstraints()
    }
        
    private func setupSubviews() {
        view.addSubview(exImageView)
        view.addSubview(exNameLabel)
        view.addSubview(recordLabel)
        view.addSubview(pickerView)
        
        exNameLabel.translatesAutoresizingMaskIntoConstraints = false
        exNameLabel.numberOfLines = 0
        exNameLabel.text = exercise?.name
        exNameLabel.textAlignment = .center
        
        exImageView.translatesAutoresizingMaskIntoConstraints = false
        exImageView.image = UIImage(named: exercise?.imageName ?? "")
        
        
        recordLabel.translatesAutoresizingMaskIntoConstraints = false
        recordLabel.numberOfLines = 0
        recordLabel.textAlignment = .center
    
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        if let val = exercise?.record {
            pickerView.selectRow(val, inComponent: 0, animated: false)
            recordLabel.text = "Текущий вес: " + "\(val)" + " кг"
        } else {
            recordLabel.text = "Текущий вес: " + "0" + " кг"
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            exImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            exImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            exImageView.widthAnchor.constraint(equalToConstant: 80),
            exImageView.heightAnchor.constraint(equalTo: exImageView.widthAnchor),
            
            exNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            exNameLabel.leftAnchor.constraint(equalTo: exImageView.rightAnchor, constant: 8),
            exNameLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            exNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            recordLabel.topAnchor.constraint(equalTo: exNameLabel.bottomAnchor),
            recordLabel.leftAnchor.constraint(equalTo: exNameLabel.leftAnchor),
            recordLabel.rightAnchor.constraint(equalTo: exNameLabel.rightAnchor),
            recordLabel.heightAnchor.constraint(equalTo: exNameLabel.heightAnchor),
            
            pickerView.topAnchor.constraint(equalTo: recordLabel.bottomAnchor, constant: 16),
            pickerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            pickerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            pickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    @objc private func didTapRightBarButton() {
        delegate?.updateRecord(with: selectedValue, for: exercise)
        self.dismiss(animated: true)
    }
    
    @objc private func didTapLeftBarButton() {
        self.dismiss(animated: true)
    }
    
    //MARK: - PickerView Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let selectedItem = pickerData[component][row] as? String, let newValue = Int(selectedItem.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            selectedValue = newValue
            recordLabel.text = "Текущий вес: " + "\(newValue)" + " кг"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerData[component][row])"
    }
}
