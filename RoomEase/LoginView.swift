//
//  LoginView.swift
//  RoomEase
//
//  Created by june taylr on 11/11/25.
//

import SwiftUI
import FirebaseAuth


struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var loginError = ""
    @State private var isLoading = false
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("RoomEase Login")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 40)

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if !loginError.isEmpty {
                    Text(loginError)
                        .foregroundColor(.red)
                        .font(.subheadline)
                }

                Button(action: loginUser) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .disabled(isLoading)

                NavigationLink(destination: SignupView()) {
                    Text("Don’t have an account? Sign up")
                        .foregroundColor(.blue)
                        .padding(.top, 10)
                }

                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }

    private func loginUser() {
        guard !email.isEmpty, !password.isEmpty else {
            loginError = "Please enter email and password."
            return
        }

        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            isLoading = false
            if let error = error {
                loginError = error.localizedDescription
            } else {
                isLoggedIn = true
                loginError = ""
                print("✅ Login successful for: \(result?.user.email ?? "")")
            }
        }
    }
}
