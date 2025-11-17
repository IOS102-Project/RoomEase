//
//  SignupView.swift
//  RoomEase
//
//  Created by june taylr on 11/11/25.
//


import SwiftUI

struct SignupView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var navigateToLogin = false

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [
                    Color(red: 0.65, green: 0.85, blue: 1.0),
                    Color(red: 0.40, green: 0.70, blue: 1.0)
                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

                VStack(spacing: 24) {
                    Text("Create Account")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)

                    VStack(spacing: 14) {
                        field("Username", text: $username)
                        field("Email", text: $email)
                        secureField("Password", text: $password)
                    }
                    .padding(30)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .frame(maxWidth: 340)

                    Button("Sign Up") {
                        navigateToLogin = true
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 40)

                    Button("Already have an account? Log In →") {
                        navigateToLogin = true
                    }
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                }
                .padding()
            }
            .navigationDestination(isPresented: $navigateToLogin) {
                LoginView()
            }
        }
    }

    private func field(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .textInputAutocapitalization(.never)
    }

    private func secureField(_ placeholder: String, text: Binding<String>) -> some View {
        SecureField(placeholder, text: text)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
    }
}
