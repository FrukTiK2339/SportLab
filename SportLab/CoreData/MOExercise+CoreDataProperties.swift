//
//  MOExercise+CoreDataProperties.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 12.01.2023.
//
//

import Foundation
import CoreData


extension MOExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOExercise> {
        return NSFetchRequest<MOExercise>(entityName: "MOExercise")
    }

    @NSManaged public var group: String
    @NSManaged public var imageName: String
    @NSManaged public var name: String
    @NSManaged public var record: Int32
    @NSManaged public var uniqueID: UUID?
    @NSManaged public var goal: MOGoal?
    @NSManaged public var training: NSSet?

}

// MARK: Generated accessors for training
extension MOExercise {

    @objc(addTrainingObject:)
    @NSManaged public func addToTraining(_ value: MOTraining)

    @objc(removeTrainingObject:)
    @NSManaged public func removeFromTraining(_ value: MOTraining)

    @objc(addTraining:)
    @NSManaged public func addToTraining(_ values: NSSet)

    @objc(removeTraining:)
    @NSManaged public func removeFromTraining(_ values: NSSet)

}

extension MOExercise : Identifiable {

}
