//
//  Training.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 12.01.2023.
//

import UIKit
import CoreData

struct Training {
    var title: String
    var exercises: [Exercise]
    
    init(title: String, exercises: [Exercise]) {
        self.title = title
        self.exercises = exercises
    }
    
    init(from moObject: MOTraining) {
        self.title = moObject.title
        let exercises = (moObject.exercises?.array as? [MOExercise])?.map {
            Exercise(from: $0) } ?? []
        self.exercises = exercises.sorted(by: {$0.name < $1.name})
    }
    
    func toMoObject(context: NSManagedObjectContext) -> MOTraining {
        let moObj = MOTraining(context: context)
        let moExercises = exercises.map {
            $0.toMoObject(context: context)
        }
        moObj.title = title
        moObj.exercises = NSOrderedSet(array: moExercises)
        return moObj
    }
}
