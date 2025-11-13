//
//  ShoppingListStandaloneApp.swift
//  RoomEase
//
//  Standalone test for Shopping List feature
//  NO Firebase dependencies - safe for independent testing
//

import SwiftUI

@main
struct ShoppingListStandaloneApp: App {
    var body: some Scene {
        WindowGroup {
            ShoppingListView()
                .environmentObject(ShoppingListViewModel())
        }
    }
}//
//  ShoppingListStandaloneApp.swift
//  RoomEase
//
//  Created by Moein Esfahani on 11/13/25.
//

