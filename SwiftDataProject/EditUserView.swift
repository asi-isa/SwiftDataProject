//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by Ali Soner Inceoglu on 06.12.25.
//

import SwiftData
import SwiftUI

struct EditUserView: View {
    @Bindable var user: User
    
    var body: some View {
        Form {
            TextField("User name", text: $user.name)
            TextField("User city", text: $user.city)
            DatePicker("Join date", selection: $user.joinDate)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let user = User(name: "Some User", city: "Some City", joinDate: .now)
        
        return EditUserView(user: user)
            .modelContainer(container)
    } catch {
        return Text("Couldn't create ModelContainer: \(error.localizedDescription)")
    }
}
