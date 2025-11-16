//
//  LoginView.swift
//  RoomEase
//
//  Created by june taylr on 11/11/25.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var loginError = ""
    @State private var navigateToHome = false

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [
                    Color(red: 0.65, green: 0.85, blue: 1.0),
                    Color(red: 0.40, green: 0.70, blue: 1.0)
                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

                VStack(spacing: 24) {
                    Text("RoomEase Login")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)

                    VStack(spacing: 14) {
                        field("Username", text: $username)
                        secureField("Password", text: $password)

                        if !loginError.isEmpty {
                            Text(loginError)
                                .foregroundColor(.red)
                                .font(.subheadline)
                        }
                    }
                    .padding(30)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .frame(maxWidth: 340)

                    Button("Login") {
                        // You can connect Firebase here later if you want real auth
                        if username.isEmpty || password.isEmpty {
                            loginError = "Enter username and password."
                        } else {
                            navigateToHome = true
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 40)

                    NavigationLink("Don’t have an account? Sign Up →", destination: SignupView())
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .padding()
            }
            .navigationDestination(isPresented: $navigateToHome) {
                ContentView()
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
