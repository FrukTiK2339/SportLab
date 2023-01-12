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
    
    public func whereIsDB() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
        return print(paths[0])
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save(training: Training) {
        let _ = training.toMoObject(context: context)
        do {
            try context.save()
            DLog("Training saved to CoreData")
        } catch {
            DLog(error.localizedDescription)
        }
    }
    
    func loadTraining(completion: @escaping ([Training]) -> Void) {
        let fetchRequest: NSFetchRequest<MOTraining> = NSFetchRequest(entityName: MOTraining.entity().name!)
        do {
            let objects = try self.context.fetch(fetchRequest)
            completion(objects.map { Training(from: $0) })
        } catch {
            completion([])
        }
        
    }
    
    
}
