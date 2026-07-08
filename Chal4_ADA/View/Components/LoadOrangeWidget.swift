//
//  LoadOrange.swift
//  Chal4_ADA
//
//  Created by Danniel on 06/07/26.
//
//

import SwiftUI

struct LoadOrangeWidget: View {
    
    let orangeFrames: [Image] = [
        Image(.orangeLoad0),
        Image(.orangeLoad1),
        Image(.orangeLoad2),
        Image(.orangeLoad3),
        Image(.orangeLoad4)
    ]
    
    var frameDuration: Double = 0.5
    
    var body: some View {
        TimelineView(.periodic(from: .now, by: frameDuration)) { context in
            let tick = Int(context.date.timeIntervalSince1970 / frameDuration)
            let index = tick % orangeFrames.count
            let dotString = String(repeating: ".", count: (index + 1) % 4)
            
            let _ = print("timeline tick \(context.date)")
            
            VStack (spacing: 16){
                orangeFrames[index]
                    .resizable()
                    .scaledToFit()
                    .frame(width: 125, height: 158)
                Text("Waiting\(dotString)")

            }

        }
    }
}

#Preview {
    LoadOrangeWidget()
}
