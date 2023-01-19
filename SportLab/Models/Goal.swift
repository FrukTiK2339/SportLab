//
//  Goal.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 12.01.2023.
//

import UIKit
import CoreData

struct Goal {
    var exercise: Exercise
    var record: Int
    
    init(exercise: Exercise, record: Int) {
        self.exercise = exercise
        self.record = record
    }
    
    init(from moObject: MOGoal) {
        self.record = Int(moObject.record)
        self.exercise = Exercise(from: moObject.exercise)
    }
    
    func toMoObject(context: NSManagedObjectContext) -> MOGoal {
        let moObj = MOGoal(context: context)
        moObj.record = Int32(record)
        moObj.exercise = exercise.toMoObject(context: context)
        return moObj
    }
}
