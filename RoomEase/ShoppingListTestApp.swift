//
//  ShoppingListTestApp.swift
//  RoomEase
//
//  Standalone test view for Shopping List feature
//  Use this to test your feature independently
//

import SwiftUI

struct ShoppingListTestApp: View {
    var body: some View {
        TabView {
            ShoppingListView()
                .tabItem {
                    Label("Shopping List", systemImage: "cart.fill")
                }
        }
    }
}

#Preview {
    ShoppingListTestApp()
}
