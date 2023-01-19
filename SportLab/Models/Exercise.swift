//
//  Exercise.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 10.01.2023.
//

import UIKit
import CoreData

struct Exercise {
    var name: String
    var group: MuscleGroup
    var imageName: String
    var record: Int
    var uniqueID: UUID?
    
    init(name: String, group: MuscleGroup, imageName: String, record: Int, uniqueID: UUID?) {
        self.name = name
        self.group = group
        self.imageName = imageName
        self.record = record
        self.uniqueID = uniqueID
    }
    
    init(from moObject: MOExercise) {
        self.name = moObject.name
        self.imageName = moObject.imageName
        self.record = Int(moObject.record)
        self.uniqueID = moObject.uniqueID
        guard let group = MuscleGroup.allCases.filter({ $0.title == moObject.group }).first else {
            self.group = .back
            return
        }
        self.group = group
    }
    
    func toMoObject(context: NSManagedObjectContext) -> MOExercise {
        let moObj = MOExercise(context: context)
        moObj.name = name
        moObj.imageName = imageName
        moObj.group = group.title
        moObj.record = Int32(record)
        moObj.uniqueID = uniqueID
        return moObj
    }
}

enum MuscleGroup: CaseIterable {
    case chest, back, biceps, triceps, shoulders, legs
    var title: String {
        switch self {
            
        case .chest:
            return "Грудные мышцы"
        case .back:
            return "Спина"
        case .biceps:
            return "Бицепс"
        case .triceps:
            return "Трицепс"
        case .shoulders:
            return "Плечи"
        case .legs:
            return "Ноги"
        }
    }
}

