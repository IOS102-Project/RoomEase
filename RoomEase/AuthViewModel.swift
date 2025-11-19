//
//  AuthViewModel.swift
//  RoomEase
//
//  Created by Carlos Sac on 11/19/25.
//

import Foundation
import Combine
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    init() {
        // Listen for auth state changes
        authStateHandler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.isAuthenticated = user != nil
        }
    }
    
    deinit {
        if let handler = authStateHandler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
    }
}
