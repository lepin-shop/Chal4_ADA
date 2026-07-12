//
//  QrScanner.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 12/07/26.
//

import SwiftUI

struct QRScannerScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    // Simple state to animate the laser line
    @State private var laserOffset: CGFloat = 10
    
    var body: some View {
        ZStack {
            // 1. Camera Feed Placeholder
            // (Replace this with your actual Camera/AVCaptureSession View)
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 2. Top Navigation Bar
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.3)) // Translucent gray/white
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Text("Validasi Penjemputan")
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 40, height: 40) // Balance spacer
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                
                Spacer()
                
                // 3. The Scanning Reticle & Laser
                ZStack(alignment: .top) {
                    // White rounded square frame
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white, lineWidth: 4)
                        .frame(width: 260, height: 260)
                    
                    // Orange Laser Line
                    Rectangle()
                        .fill(Color.orange)
                        .frame(width: 260, height: 2)
                        .offset(y: laserOffset)
                        .animation(
                            Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true),
                            value: laserOffset
                        )
                }
                .onAppear {
                    // Start the laser animation
                    laserOffset = 250
                }
                
                Spacer()
                
                // 4. Bottom Info Bar
                HStack(spacing: 16) {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.system(size: 40))
                        .foregroundStyle(Color.blue)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Pindai QR untuk menyelesaikan\ntransaksi")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Button(action: {
                            print("Learn More Tapped")
                        }) {
                            Text("Learn More")
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(Color.orange)
                                .underline()
                        }
                    }
                    Spacer()
                }
                .padding(24)
                .background(Color(red: 0.1, green: 0.1, blue: 0.1)) // Dark background
            }
            .safeAreaInset(edge: .bottom) {
                // Extends the dark bottom bar safely into the home indicator area
                Color(red: 0.1, green: 0.1, blue: 0.1).frame(height: 0)
            }
        }
    }
}
