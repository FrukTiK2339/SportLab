//
//  CoreDataManager.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 10.01.2023.
//
//  CRUD по CoreData.

import UIKit
import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "SportLab")
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (()-> Void)? = nil) {
        persistentContainer.loadPersistentStores { (description, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
    
    public func whereIsDB() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
        return print(paths[0])
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                DLog(error.localizedDescription)
            }
        }
    }
    
    
    
    
}
//MARK: - Training Page
extension CoreDataManager {
    ///TRAINING
    func createTrainingFetchedResultController(filter: String? = nil) -> NSFetchedResultsController<MOTraining> {
        let request: NSFetchRequest<MOTraining> = MOTraining.fetchRequest()
        
        
        let sortDiscriptor = NSSortDescriptor(keyPath: \MOTraining.title, ascending: false)
        request.sortDescriptors = [sortDiscriptor]
        
        if let filter = filter {
            let predicate = NSPredicate(format: "text contains[cd] %@", filter)
            request.predicate = predicate
        }
        
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    func save(training: Training) {
        let _ = training.toMoObject(context: viewContext)
        save()
    }
    
    func delete(moTraining: MOTraining) {
        viewContext.delete(moTraining)
        save()
    }
    
    func save(exercise: Exercise) {
        let _ = exercise.toMoObject(context: viewContext)
        save()
    }
    
    ///EXERSICE
    func setExercise(newRecordValue: Int, by exerciseID: UUID) {
        let request : NSFetchRequest<MOExercise> = MOExercise.fetchRequest()
        let predicate = NSPredicate(format: "uniqueID = %@", exerciseID as CVarArg)
        request.predicate = predicate
        do{
            guard let object = try self.viewContext.fetch(request).first else { return }
            object.record = Int32(newRecordValue)
        } catch {
            DLog("Error saving new results \(error)")
        }
        save()
    }
    
    
    ///GOAL
    func createGoal(with value: Int, for exercise: Exercise) {
        let request = MOGoal.fetchRequest()
        guard let objects = try? self.viewContext.fetch(request),
              !objects.filter({$0.exercise.name == exercise.name}).isEmpty
        else {
            let newGoal = MOGoal(context: viewContext)
            newGoal.exercise = exercise.toMoObject(context: viewContext)
            newGoal.record = Int32(value)
            save()
            return
        }
        if let record = objects
            .filter({$0.exercise.name == exercise.name })
            .sorted(by: {$0.record > $1.record})
            .first?.record {
            if record < value {
                setGoal(newRecordValue: value, by: exercise)
            }
        }
        
        
        save()
    }
    
    func loadGoals() -> [Goal] {
        var goals = [Goal]()
        let request = MOGoal.fetchRequest()

        guard let objects = try? self.viewContext.fetch(request) else {
            return []
        }
        goals = objects.map({ Goal(from: $0) })
        return goals
    }
    
    func setGoal(newRecordValue: Int, by exercise: Exercise) {
        let request : NSFetchRequest<MOGoal> = MOGoal.fetchRequest()
        let predicate = NSPredicate(format: "exercise.name = %@", exercise.name as CVarArg)
        request.predicate = predicate
        do{
            guard let object = try self.viewContext.fetch(request).first else { return }
            object.record = Int32(newRecordValue)
        } catch {
            DLog("Error saving new results \(error)")
        }
        save()
    }
    
    func createGoalFRC(filter: String? = nil) -> NSFetchedResultsController<MOGoal> {
        let request: NSFetchRequest<MOGoal> = MOGoal.fetchRequest()
        
        
        let sortDiscriptor = NSSortDescriptor(keyPath: \MOGoal.record, ascending: false)
        request.sortDescriptors = [sortDiscriptor]
        
        if let filter = filter {
            let predicate = NSPredicate(format: "text contains[cd] %@", filter)
            request.predicate = predicate
        }
        
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
    }
}
