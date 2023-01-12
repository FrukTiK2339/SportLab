//
//  MOTraining+CoreDataProperties.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 12.01.2023.
//
//

import Foundation
import CoreData


extension MOTraining {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOTraining> {
        return NSFetchRequest<MOTraining>(entityName: "MOTraining")
    }

    @NSManaged public var title: String
    @NSManaged public var exercises: NSOrderedSet?

}

// MARK: Generated accessors for exercises
extension MOTraining {

    @objc(insertObject:inExercisesAtIndex:)
    @NSManaged public func insertIntoExercises(_ value: MOExercise, at idx: Int)

    @objc(removeObjectFromExercisesAtIndex:)
    @NSManaged public func removeFromExercises(at idx: Int)

    @objc(insertExercises:atIndexes:)
    @NSManaged public func insertIntoExercises(_ values: [MOExercise], at indexes: NSIndexSet)

    @objc(removeExercisesAtIndexes:)
    @NSManaged public func removeFromExercises(at indexes: NSIndexSet)

    @objc(replaceObjectInExercisesAtIndex:withObject:)
    @NSManaged public func replaceExercises(at idx: Int, with value: MOExercise)

    @objc(replaceExercisesAtIndexes:withExercises:)
    @NSManaged public func replaceExercises(at indexes: NSIndexSet, with values: [MOExercise])

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: MOExercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: MOExercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSOrderedSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSOrderedSet)

}

extension MOTraining : Identifiable {

}
