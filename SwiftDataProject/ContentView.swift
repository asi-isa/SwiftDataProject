//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Ali Soner Inceoglu on 06.12.25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingUpcomingByDefault = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]
    
    var minimumJoinDate: Date {
        showingUpcomingByDefault ? .now : .distantPast
    }
    
    var body: some View {
        NavigationStack {
            UsersView(minimumJoinDate: minimumJoinDate, sortOrder: sortOrder)
                .navigationTitle("Users")
                .toolbar {
                    Button("Add Samples", systemImage: "plus") {
                        try? modelContext.delete(model: User.self)
                        
                        let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                        let second = User(name: "Bad Bunny", city: "Nueva Yol", joinDate: .now.addingTimeInterval(86400 * -5))
                        let third = User(name: "Karol G", city: "Bichota", joinDate: .now.addingTimeInterval(86400 * 5))
                        let fourth = User(name: "Xi Ling", city: "Berlin", joinDate: .now.addingTimeInterval(86400 * 10))
                        
                        modelContext.insert(first)
                        modelContext.insert(second)
                        modelContext.insert(third)
                        modelContext.insert(fourth)
                    }
                    
                    Button(showingUpcomingByDefault ? "Show Everyone" : "Show Upcoming") {
                        showingUpcomingByDefault.toggle()
                    }
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by name")
                                .tag([
                                    SortDescriptor(\User.name),
                                    SortDescriptor(\User.joinDate)
                                ])
                            
                            Text("Sort by Join Date")
                                .tag([
                                    SortDescriptor(\User.joinDate),
                                    SortDescriptor(\User.name)
                                ])
                        }
                    }
                }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
            .modelContainer(for: User.self)
    }
}
