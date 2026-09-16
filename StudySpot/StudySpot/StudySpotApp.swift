//
//  StudySpotApp.swift
//  StudySpot
//
//  Created by Kenny Ding on 9/15/26.
//

import SwiftUI
import FirebaseCore

@main
struct StudySpotApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
