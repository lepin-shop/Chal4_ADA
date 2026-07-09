//
//  Banner.swift
//  Chal4_ADA
//
//  Created by Danniel on 03/07/26.
//

import SwiftUI


// TODO: Buat ini jadi reusable di Page Profile
struct BannerCard: View {
    var actionCallBack: (() -> Void)
    
    init (actionCallBack: @escaping (() -> Void) = {}) {
        self.actionCallBack = actionCallBack
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            VStack(alignment: .trailing, spacing: 0) {
                Text("Monthly Performance")
                    .font(
                        .caption2
                    )
                    .fontWeight(
                        .light
                    )
                    .padding(.bottom, 5)
                    .padding(.top, 24)
                
                Text("30 kg Upcycled")
                    .font(
                        .title3
                    )
                    .fontWeight(
                        .bold
                    )
                    .padding(.bottom, 9)
                
                Text("Recovered potential losses\ninto gains.")
                    .font(
                        .caption2
                    )
                    .fontWeight(
                        .medium
                    )
                    .multilineTextAlignment(.trailing)
                    .padding(.bottom, 20)
                
                Button {
                    actionCallBack()
                } label: {
                    Label("Posting", systemImage: "plus")
                        .font(.title3)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                        .glassEffect()
                }
            }
            .foregroundStyle(.white)
        }
        .padding(.trailing, 16)
        .padding(.bottom, 24)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                LinearGradient(
                    colors: [.accent1, .bannerGreenEnd],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                HStack {
                    VStack (spacing: 0) {
                        Spacer()
                        Image(.banner)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 200, alignment: .bottomLeading)
                    }
                    Spacer()
                }
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    MainTabView()
}
