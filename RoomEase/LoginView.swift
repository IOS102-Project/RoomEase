//
//  LoginView.swift
//  RoomEase
//
//  Created by june taylr on 11/11/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var loginError = ""
    @State private var isLoading = false
    @State private var navigateToHome = false

    var body: some View {
        NavigationStack {
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
                    Text("RoomEase Login")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)

                    VStack(spacing: 16) {
                        TextField("Username", text: $username)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .foregroundColor(.black)
                            .textInputAutocapitalization(.never)
                            .multilineTextAlignment(.center)

                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)

                        if !loginError.isEmpty {
                            Text(loginError)
                                .foregroundColor(.red)
                                .font(.subheadline)
                        }

                        Button(action: loginUser) {
                            if isLoading {
                                ProgressView().tint(.white)
                            } else {
                                Text("Login")
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

                    NavigationLink("Don't have an account? Sign Up →", destination: SignupView())
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

    private func loginUser() {
        guard !username.isEmpty, !password.isEmpty else {
            loginError = "Please enter username and password."
            return
        }

        isLoading = true
        let db = Firestore.firestore()
        db.collection("users")
            .whereField("username", isEqualTo: username.lowercased())
            .getDocuments { snapshot, error in
                if let error = error {
                    loginError = error.localizedDescription
                    isLoading = false
                    return
                }

                guard let document = snapshot?.documents.first,
                      let email = document["email"] as? String else {
                    loginError = "Username not found."
                    isLoading = false
                    return
                }

                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    isLoading = false
                    if let error = error {
                        loginError = error.localizedDescription
                    } else {
                        loginError = ""
                        navigateToHome = true
                    }
                }
            }
    }
}
