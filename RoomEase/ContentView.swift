//
//  ContentView.swift
//  RoomEase
//
//  Created by Carlos Sac on 11/5/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BillsListView()
                .tabItem {
                    Label("Bills", systemImage: "list.bullet")
                }
            
            ChoresListView()
                .tabItem {
                    Label("Chores", systemImage: "checkmark.circle")
                }
            
            ShoppingListView()
                .tabItem {
                    Label("Shopping", systemImage: "cart")
                }
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
