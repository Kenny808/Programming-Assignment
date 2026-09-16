//
//  StudySpotDisplay.swift
//  StudySpot
//
//  Created by Kenny Ding on 9/14/26.
//

import SwiftUI

struct StudySpotCard: View {

    let spot: StudySpot

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text(spot.name)
                .font(.title2)
                .fontWeight(.semibold)

            Text("Noise 🔊: \(spot.noise)")

            Text("Outlets 🔌: \(spot.outlets)")
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding()
        .background(
            Color(.secondarySystemBackground)
        )
        .cornerRadius(12)
    }
}
