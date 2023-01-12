//
//  UserData.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 12.01.2023.
//

import UIKit
import CoreData

struct UserData {
    var goals: [Goal]
    var userInfo: UserInfo
    
}

struct Goal {
    var exercise: Exercise
    var record: Int
}

struct Training {
    var title: String
    var exercises: [Exercise]
    
    init(title: String, exercises: [Exercise]) {
        self.title = title
        self.exercises = exercises
    }
    
    init(from moObject: MOTraining) {
        self.title = moObject.title
        self.exercises = (moObject.exercises?.array as? [MOExercise])?.map {
            Exercise(from: $0) } ?? []
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

struct UserInfo {
    var name: String
    var targetWeight: Int
    var currentWeight: Int
}




