//
//  todoApp.swift
//  todo
//
//  Created by Domenic Moran on 17.08.22.
//

import SwiftUI

@main
struct todoApp: App {
    
    let manager = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, manager.persistentContainer.viewContext)
        }
    }
}
