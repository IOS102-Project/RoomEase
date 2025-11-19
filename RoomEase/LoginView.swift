//
//  LoginView.swift
//  RoomEase
//
//  Created by june taylr on 11/11/25.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var username = ""
    @State private var password = ""
    @State private var loginError = ""

    var body: some View {
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
                    field("Email", text: $username)
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
                    loginUser()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .padding(.horizontal, 40)

                NavigationLink("Don't have an account? Sign Up →", destination: SignupView())
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
            .padding()
        }
    }

    private func loginUser() {
        guard !username.isEmpty, !password.isEmpty else {
            loginError = "Enter email and password."
            return
        }
        
        Auth.auth().signIn(withEmail: username, password: password) { result, error in
            if let error = error {
                loginError = error.localizedDescription
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

#Preview {
    LoginView()
}
