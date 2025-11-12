//
//  SignupView.swift
//  RoomEase
//
//  Created by june taylr on 11/11/25.
//

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var signupError = ""
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 40)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if !signupError.isEmpty {
                Text(signupError)
                    .foregroundColor(.red)
                    .font(.subheadline)
            }

            Button(action: registerUser) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .disabled(isLoading)

            Spacer()
        }
        .padding()
    }

    private func registerUser() {
        guard !email.isEmpty, !password.isEmpty else {
            signupError = "Please enter email and password."
            return
        }

        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            isLoading = false
            if let error = error {
                signupError = error.localizedDescription
            } else {
                signupError = ""
                print("✅ Signup successful for: \(result?.user.email ?? "")")
            }
        }
    }
}
