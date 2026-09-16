//
//  ContentView.swift
//  Fruit Survey
//
//  Created by Kenny Ding on 9/13/26.
//

import SwiftUI

struct ContentView: View {
    @State private var fruit = "Nothing selected"

    var body: some View {
        VStack(spacing: 20) {
            Text("Fruit Survey 🍎🍉🍊🍋")
                .font(.largeTitle)
                .bold()

            Text("What is your favorite fruit?")
                .font(.title2)

            Button("Apple") {
                fruit = "Apple"
            }
            .buttonStyle(.bordered)

            Button("Watermelon") {
                fruit = "Watermelon"
            }
            .buttonStyle(.bordered)

            Button("Orange") {
                fruit = "Orange"
            }
            .buttonStyle(.bordered)
            
            Button("Lemon") {
                fruit = "Lemon"
            }
            .buttonStyle(.bordered)
            
            Button("Other/Not Listed") {
                fruit = "Other/Not Listed"
            }
            .buttonStyle(.bordered)

            Text("You selected: \(fruit)")
                .font(.headline)
                .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
