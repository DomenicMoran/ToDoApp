//
//  AddTaskView.swift
//  todo
//
//  Created by Domenic Moran on 17.08.22.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var title = ""
    @State private var priority = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Titel")) {
                    TextField("Aufgabe", text: $title)
                }
                Section(header: Text("Priorität")) {
                    Picker("", selection: $priority) {
                        Text("Normal").tag(0)
                        Text("!!").tag(1)
                        Text("!!!").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Neuer Aufgabe")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Abbrechen") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Speichern") {
                        createTask()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    func createTask() {
        let task = Task(context: viewContext)
        task.id = UUID()
        task.title = title
        task.priority = Int16(priority)
        task.timestamp = Date()
        
        try? viewContext.save()
    }
    
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
