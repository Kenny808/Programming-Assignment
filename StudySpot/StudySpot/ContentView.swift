//
//  ContentView.swift
//  StudySpot
//
//  Created by Kenny Ding on 9/13/26.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ContentView: View {

    @State private var spots: [StudySpot] = []

    @State private var showingAddSpot = false

    @State private var errorMessage = ""

    var body: some View {

        NavigationStack {

            VStack(alignment: .leading, spacing: 16) {

                Text("Study Spot Finder")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                if !errorMessage.isEmpty {

                    Text(errorMessage)
                        .foregroundStyle(.red)
                }

                if spots.isEmpty {

                    Text("No study spots yet.")
                        .foregroundStyle(.secondary)

                } else {

                    ScrollView {

                        VStack(spacing: 12) {

                            ForEach(spots) { spot in

                                StudySpotCard(spot: spot)
                            }
                        }
                    }
                }

                Button("Add Study Spot") {

                    showingAddSpot = true
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)

                Button("Log Out") {

                    do {

                        try Auth.auth().signOut()

                    } catch {

                        errorMessage = error.localizedDescription
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .sheet(isPresented: $showingAddSpot) {

                AddStudySpotView {
                    loadStudySpots()
                }
            }
            .onAppear {

                loadStudySpots()
            }
        }
    }

    func loadStudySpots() {

        let db = Firestore.firestore()

        db.collection("studySpots")
            .order(by: "name")
            .getDocuments { snapshot, error in

                if let error = error {

                    errorMessage =
                        "Could not load study spots: \(error.localizedDescription)"

                    print("FIRESTORE LOAD ERROR:", error)

                    return
                }

                guard let documents = snapshot?.documents else {

                    spots = []
                    return
                }

                spots = documents.map { document in

                    let data = document.data()

                    return StudySpot(

                        id: document.documentID,

                        name: data["name"] as? String ?? "Unknown",

                        noise: data["noise"] as? String ?? "Unknown",

                        outlets: data["outlets"] as? String ?? "Unknown"
                    )
                }
            }
    }
}
