//
//  ItemDetailScreen.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 03/07/26.
//

import Foundation
import SwiftUI


struct ItemDetailScreen: View {
    let item: Item
    @Environment(\.dismiss) private var dismiss
    
    // Bottom Sheet States
    @State private var showSheet = false
    @State private var activeSheetMode: SheetMode = .checkout
    @State private var showFeedback = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(.systemGray6).ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        // 2. Molecule: Gallery
                        ImageGalleryCarousel(item: item, grade: String(describing: item.qualityGrade))
                        
                        // 3. Atom: Fulfillment Status
                        FulfillmentStatusView(statusText: item.expiresAt)
                            .padding(.top, 4)
                        
                        Divider()
                        
                        // 4. Molecule: Header Info
                        DetailHeaderInfo(title: item.title, price: item.pricePerUnit, stock: item.quantityAvailable)
                        
                        Divider()
                        
                        // 5. Molecule: Seller Info (Reusing the row from the card design!)
                        SellerCompactRow(sellerName: item.seller.name)
                        
                        Divider()
                        
                        // 6. Molecule: Description
                        ExpandableDescription(description: item.itemDescription)
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 100) // Padding for bottom button
                }
            }
            
            // 7. Floating Action Bottom Bar
            bottomActionBar
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("Detail Produk")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showSheet) {
            DynamicSheet(
                mode: activeSheetMode,
                item: item,
                onConfirm: {
                    activeSheetMode = .qrCode
                }
            )
            .presentationDetents(
                activeSheetMode == .checkout ? [.fraction(0.85), .large] : [.fraction(0.60)]
            )
            .presentationDragIndicator(.visible)
        }
        .fullScreenCover(isPresented: $showFeedback) {
            FeedbackScreen()
        }
    }
    
    private var bottomActionBar: some View {
        VStack {
            Button(action: { showSheet = true }) {
                Text("Lanjut Pemesanan")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color(red: 0.35, green: 0.65, blue: 0.45))
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 8)
        }
        .background(
            Color(.systemGray6)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: -5)
                .ignoresSafeArea(edges: .bottom)
        )
    }
}


