//
//  SignupView.swift
//  RoomEase
//
//  Created by june taylr on 11/11/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignupView: View {
    @Environment(\.dismiss) var dismiss
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var signupError = ""
    @State private var isLoading = false

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.65, green: 0.85, blue: 1.0),
                    Color(red: 0.40, green: 0.70, blue: 1.0)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("Create Account")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                VStack(spacing: 16) {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .textInputAutocapitalization(.never)

                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .textInputAutocapitalization(.never)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)

                    if !signupError.isEmpty {
                        Text(signupError)
                            .foregroundColor(.red)
                            .font(.subheadline)
                    }

                    Button(action: registerUser) {
                        if isLoading {
                            ProgressView().tint(.white)
                        } else {
                            Text("Sign Up")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                    }
                    .disabled(isLoading)
                }
                .padding(30)
                .background(Color.white.opacity(0.9))
                .cornerRadius(20)
                .shadow(radius: 10)
                .frame(maxWidth: 340)

                Button("Already have an account? Log In →") {
                    dismiss()
                }
                .foregroundColor(.white)
                .fontWeight(.semibold)
            }
            .padding()
        }
    }

    private func registerUser() {
        guard !username.isEmpty, !email.isEmpty, !password.isEmpty else {
            signupError = "Please fill in all fields."
            return
        }

        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                signupError = error.localizedDescription
                isLoading = false
            } else if let uid = result?.user.uid {
                let db = Firestore.firestore()
                db.collection("users").document(uid).setData([
                    "username": username.lowercased(),
                    "email": email
                ]) { err in
                    isLoading = false
                    if let err = err {
                        signupError = err.localizedDescription
                    } else {
                        signupError = ""
                        dismiss() // Return to LoginView
                    }
                }
            }
        }
    }
}
