//
//  StatusPostSegmentedControl.swift
//  Chal4_ADA
//
//  Created by Danniel on 08/07/26.
//

import SwiftUI

struct StatusPostSegmentedControl: View {
    @Binding var currentPostFilter: PostFilter

    var body: some View {
        VStack {
            Picker("Your Posts Filter", selection: $currentPostFilter) {
                Text("Active").tag(PostFilter.active)
                Text("Booked").tag(PostFilter.booked)
                Text("Done").tag(PostFilter.done)
            }
            .pickerStyle(.segmented)
        }
    }
}
