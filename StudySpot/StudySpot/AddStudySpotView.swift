//
//  AddStudySpotView.swift
//  StudySpot
//
//  Created by Kenny Ding on 9/15/26.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AddStudySpotView: View {

    @Environment(\.dismiss) var dismiss

    var onSaved: () -> Void

    @State private var name = ""
    @State private var noise = "Quiet"
    @State private var outlets = "Many"

    @State private var message = ""
    @State private var isSaving = false

    var body: some View {

        NavigationStack {

            Form {

                Section("Study Spot") {

                    TextField(
                        "Study spot name",
                        text: $name
                    )

                    Picker("Noise Level", selection: $noise) {

                        Text("Quiet")
                            .tag("Quiet")

                        Text("Moderate")
                            .tag("Moderate")

                        Text("Loud")
                            .tag("Loud")
                    }

                    Picker(
                        "Number of Outlets",
                        selection: $outlets
                    ) {

                        Text("None")
                            .tag("None")

                        Text("Some")
                            .tag("Some")

                        Text("Many")
                            .tag("Many")
                    }
                }

                Section {

                    Button {

                        saveStudySpot()

                    } label: {

                        if isSaving {

                            ProgressView()

                        } else {

                            Text("Save Study Spot")
                        }
                    }
                    .disabled(isSaving)
                }

                if !message.isEmpty {

                    Section {

                        Text(message)
                            .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("Add Study Spot")
        }
    }

    func saveStudySpot() {

        guard !name.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty else {

            message = "Please enter a study spot name."
            return
        }

        guard let user = Auth.auth().currentUser else {

            message = "You are not logged in."
            return
        }

        isSaving = true
        message = ""

        let db = Firestore.firestore()

        let spotData: [String: Any] = [

            "name": name.trimmingCharacters(
                in: .whitespacesAndNewlines
            ),

            "noise": noise,

            "outlets": outlets,

            "userID": user.uid,

            "createdAt": Timestamp(date: Date())
        ]

        db.collection("studySpots")
            .addDocument(data: spotData) { error in

                isSaving = false

                if let error = error {

                    message =
                        "Could not save: \(error.localizedDescription)"

                    print("FIRESTORE SAVE ERROR:", error)

                    return
                }

                print("Study spot saved!")

                onSaved()

                dismiss()
            }
    }
}
