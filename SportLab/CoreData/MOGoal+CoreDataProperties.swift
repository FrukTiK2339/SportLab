//
//  MOGoal+CoreDataProperties.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 12.01.2023.
//
//

import Foundation
import CoreData


extension MOGoal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOGoal> {
        return NSFetchRequest<MOGoal>(entityName: "MOGoal")
    }

    @NSManaged public var record: Int32
    @NSManaged public var exercise: MOExercise?

}

extension MOGoal : Identifiable {

}
