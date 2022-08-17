//
//  ContentView.swift
//  todo
//
//  Created by Domenic Moran on 17.08.22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.priority, ascending: false), NSSortDescriptor(keyPath: \Task.timestamp, ascending: true)])
    var tasks: FetchedResults<Task>
    
    @State private var presentSheet = false
    
    private var priorityRepresentation = ["", "!!", "!!!"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    HStack {
                        Text(priorityRepresentation[Int(task.priority)])
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
                        Text(task.title ?? "N/A")
                    }
                }
                .onDelete(perform: deleteItems)
                
            }
            
            .listStyle(PlainListStyle())
            .navigationTitle("ToDo's")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .disabled(tasks.isEmpty)
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        presentSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
            }
            .sheet(isPresented: $presentSheet) {
                AddTaskView()
            }
        }
        
    }
    
    func deleteItems(offsets: IndexSet) {
        offsets.map { tasks[$0] }.forEach(viewContext.delete)
        
        try? viewContext.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, CoreDataManager.preview.persistentContainer.viewContext)
    }
}
