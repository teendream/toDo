//
//  DataManager.swift
//  DemoToDo
//
//  Created by Azizbek Abdulkhakimov on 10/01/24.
//

import Foundation
import CoreData

protocol DataManagerProtocol {
    func fetchTasks() -> [Exercise]?
    @discardableResult func createTask(taskName: String) -> Exercise?
    func removeTask(taskName: String)
}

struct DataManager: DataManagerProtocol {
    
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Exercise")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Cannot find any records")
            }
        }
        
        return container
    }()
    
    @discardableResult
    func createTask(taskName: String) -> Exercise? {
        
        let task = NSEntityDescription.insertNewObject(forEntityName: "Exercise", into: context) as! Exercise
        
        task.title = taskName
        
        do {
            try context.save()
            return task
        } catch let createError {
            print("Failed to create: \(createError)")
        }
        
        return nil
    }
    
    func removeTask(taskName: String) {
        let request = NSFetchRequest<Exercise>(entityName: "Exercise")
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "title == %@", taskName)
        if let result = try? context.fetch(request) {
            for obj in result {
                context.delete(obj)
            }
        }
        
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    @discardableResult
    func fetchTasks() -> [Exercise]? {
        let fetchRequest = NSFetchRequest<Exercise>(entityName: "Exercise")
        
        do {
            let tasks = try context.fetch(fetchRequest)
            return tasks
        } catch _ {
            print("Failed to fetch tasks")
        }
        
        return nil
    }
}
