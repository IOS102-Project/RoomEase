//
//  RoomEaseApp.swift
//  RoomEase
//
//  Created by Carlos Sac on 11/5/25.
//

import SwiftUI
import FirebaseCore

@main
struct RoomEaseApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var showLaunch = true

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if showLaunch {
                LaunchView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showLaunch = false
                        }
                    }
            } else {
                if authViewModel.isAuthenticated {
                    ContentView()
                        .environmentObject(authViewModel)
                } else {
                    NavigationStack {
                        LoginView()
                    }
                    .environmentObject(authViewModel)
                }
            }
        }
    }
}
