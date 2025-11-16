//
//  AccountView.swift
//  RoomEase
//
//  Created by Carlos Sac on 11/15/25.
//


import SwiftUI
import FirebaseAuth

struct AccountView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text("Account")
                .font(.title)
                .fontWeight(.bold)

            Button("Logout") {
                do {
                    try Auth.auth().signOut()
                    dismiss()
                } catch {
                    print("Error signing out: \(error.localizedDescription)")
                }
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}


#Preview {
    AccountView()
}
