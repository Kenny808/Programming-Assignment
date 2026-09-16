//
//  LoginView.swift
//  StudySpot
//
//  Created by Kenny Ding on 9/15/26.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {

    @State private var email = ""
    @State private var password = ""

    @State private var isCreatingAccount = false
    @State private var message = ""

    var body: some View {

        VStack(spacing: 20) {

            Text("Study Spot Finder")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(
                isCreatingAccount
                ? "Create an account"
                : "Log in"
            )
            .font(.title2)

            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            Button(
                isCreatingAccount
                ? "Create Account"
                : "Log In"
            ) {

                if isCreatingAccount {
                    createAccount()
                } else {
                    login()
                }
            }
            .buttonStyle(.borderedProminent)

            Button(
                isCreatingAccount
                ? "Already have an account? Log In"
                : "Create a new account"
            ) {

                isCreatingAccount.toggle()
                message = ""
            }

            if !message.isEmpty {

                Text(message)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }

    func createAccount() {

        guard !email.isEmpty else {
            message = "Please enter an email."
            return
        }

        guard !password.isEmpty else {
            message = "Please enter a password."
            return
        }

        Auth.auth().createUser(
            withEmail: email,
            password: password
        ) { result, error in

            if let error = error {

                message = error.localizedDescription
                print("CREATE ACCOUNT ERROR:", error)

            } else {

                message = ""
                print("Account created successfully!")
            }
        }
    }

    func login() {

        guard !email.isEmpty else {
            message = "Please enter an email."
            return
        }

        guard !password.isEmpty else {
            message = "Please enter a password."
            return
        }

        Auth.auth().signIn(
            withEmail: email,
            password: password
        ) { result, error in

            if let error = error {

                message = error.localizedDescription
                print("LOGIN ERROR:", error)

            } else {

                message = ""
                print("Login successful!")
            }
        }
    }
}
