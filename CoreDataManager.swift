//
//  CoreDataManager.swift
//  todo
//
//  Created by Domenic Moran on 17.08.22.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    static let preview: CoreDataManager = {
        let manager = CoreDataManager(inMemory: true)
        let viewContext = manager.persistentContainer.viewContext
        
        for _ in 0..<2 {
            let task = Task(context: viewContext)
            task.id = UUID()
            task.title = "tilemuster \((1...50).randomElement()!)"
            task.priority = (0...2).randomElement()!
            task.timestamp = Date()
        }
        try? viewContext.save()
        
        return manager
    }()
    
    let persistentContainer: NSPersistentContainer
    
    private init (inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "todo")
        
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Error: \(error)")
            }
        }
    }
}
