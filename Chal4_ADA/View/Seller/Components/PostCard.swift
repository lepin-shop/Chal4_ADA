//
//  PostCard.swift
//  Chal4_ADA
//
//  Created by Danniel on 03/07/26.
//

import SwiftUI

struct PostCard: View {
    let imageName: ImageResource
    let grade: String
    let title: String
    let weight: String
    let price: String

    var body: some View {
        VStack(spacing: 0) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 144)

            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(grade)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(.accents)
                    Text(title)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(weight)
                        .font(.subheadline)
                    Text(price)
                        .font(.headline)
                        .foregroundStyle(.destructive)
                }

                Spacer()

                Button { } label: {
                    Label("Edit post", systemImage: "pencil")
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                        .background(Color.accents, in: Capsule())
                }
            }
            .padding()
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    MainTabView()
}
