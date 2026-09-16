//
//  RootView.swift
//  StudySpot
//
//  Created by Kenny Ding on 9/15/26.
//

import SwiftUI
import FirebaseAuth

struct RootView: View {

    @State private var user: User?

    var body: some View {

        Group {

            if user != nil {
                ContentView()
            } else {
                LoginView()
            }
        }
        .onAppear {

            user = Auth.auth().currentUser

            Auth.auth().addStateDidChangeListener { _, currentUser in
                user = currentUser
            }
        }
    }
}
