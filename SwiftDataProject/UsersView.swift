//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Ali Soner Inceoglu on 06.12.25.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    var body: some View {
        List(users) { user in
            HStack {
                Text(user.name)
                
                Spacer()
                
                Text(String(user.jobs?.count ?? 0))
            }
        }
        .onAppear(perform: addSample)
    }
    
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }
    
    func addSample() {
        let user = User(name: "Dieter Bohlen", city: "Deutschland", joinDate: .now)
        let job1 = Job(name: "Job1", priority: 1)
        let job2 = Job(name: "Job2", priority: 2)
        
        modelContext.insert(user)
        
        user.jobs?.append(job1)
        user.jobs?.append(job2)
    }
}

#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
