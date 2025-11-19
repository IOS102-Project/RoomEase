//
//  AccountView.swift
//  RoomEase
//
//  Created by Carlos Sac on 11/15/25.
//


import SwiftUI

struct AccountView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Account")
                .font(.title)
                .fontWeight(.bold)

            Button("Logout") {
                authViewModel.signOut()
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
