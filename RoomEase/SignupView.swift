//
//  SignupView.swift
//  RoomEase
//
//  Created by june taylr on 11/11/25.
//


import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var signupError = ""
    @State private var isLoading = false

    var body: some View {
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
                    field("Name", text: $username)
                    field("Email", text: $email)
                    secureField("Password", text: $password)
                    
                    if !signupError.isEmpty {
                        Text(signupError)
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(30)
                .background(Color.white.opacity(0.9))
                .cornerRadius(20)
                .shadow(radius: 10)
                .frame(maxWidth: 340)

                Button("Sign Up") {
                    signupUser()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(isLoading ? Color.gray : Color.blue)
                .cornerRadius(10)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .padding(.horizontal, 40)
                .disabled(isLoading)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(false)
    }

    private func signupUser() {
        signupError = ""
        
        guard !username.isEmpty else {
            signupError = "Please enter a name."
            return
        }
        
        guard !email.isEmpty else {
            signupError = "Please enter an email."
            return
        }
        
        guard !password.isEmpty else {
            signupError = "Please enter a password."
            return
        }
        
        guard password.count >= 6 else {
            signupError = "Password must be at least 6 characters."
            return
        }
        
        isLoading = true
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            isLoading = false
            
            if let error = error {
                signupError = error.localizedDescription
                return
            }
            
            
            if let user = result?.user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = username
                changeRequest.commitChanges { error in
                    if let error = error {
                        print("Error updating profile: \(error.localizedDescription)")
                    }
                }
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
