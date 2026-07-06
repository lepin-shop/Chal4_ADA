//
//  YourPostSection.swift
//  Chal4_ADA
//
//  Created by Danniel on 03/07/26.
//

import SwiftUI

struct YourPostsSection: View {
    @State var currentPostFilter: PostFilter = .active
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your posts")
                .font(.title.bold())
            
            SegmentedFilter(currentPostFilter: $currentPostFilter)
            Group {
                switch currentPostFilter {
                case .active:
                    LazyVStack(spacing: 16) {
                        PostCard(imageName: .banana, grade: "Grade B",
                                 title: "Pisang Ripe", weight: "3 kg", price: "Rp. 15.000")
                    }
                case .booked:
                    LazyVStack(spacing: 16) {
                        PostCard(imageName: .potato, grade: "Grade B",
                                 title: "Potato", weight: "3 kg", price: "Rp. 15.000")
                        PostCard(imageName: .banana, grade: "Grade B",
                                 title: "Mangga Ripe", weight: "5 kg", price: "Rp. 20.000")
                    }
                case .done:
                    LazyVStack(spacing: 16) {
                        PostCard(imageName: .potato, grade: "Grade B",
                                 title: "Potato", weight: "5 kg", price: "Rp. 20.000")
                    }
                }
            }
        }
    }
}

struct SegmentedFilter: View {
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

#Preview {
    MainTabView()
}
