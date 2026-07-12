//
//  ActiveOrderDetail.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 11/07/26.
//

import SwiftUI

struct ActiveOrderDetailScreen: View {
    // Assuming you pass the Order or Item from your .myOrder array
    let item: Item
    let quantityBought: Int
    let orderNotes: String = "yang ambil temenku cici-cirinya botak tinggi kurus" // Dummy note
    
    @State private var showSheet = false
    @State private var activeSheetMode: SheetMode = .qrCode
    @State private var isShowingCancelAlert: Bool = false
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(.systemGray6).ignoresSafeArea()
            
            VStack(spacing: 0) {
                CountdownBanner(timeRemaining: item.expiresAt)
                
                ScrollView {
                    VStack(spacing: 16) {
                        OrderSummaryCard(item: item, quantityBought: quantityBought)
                        NoteCard(note: orderNotes)
                        QRActionCard {
                            activeSheetMode = .qrCode
                            showSheet = true
                        }
                    }
                    .padding(16)
                    .padding(.bottom, 100) // Safe padding for the sticky bottom button
                }
            }
            
            // 6. Sticky Bottom Action Bar
            VStack {
                SecondaryActionButton(title: "Batalkan pemesanan") {
                    isShowingCancelAlert = true
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
        .sheet(isPresented: $showSheet) {
                    DynamicSheet(
                        mode: activeSheetMode,
                        item: item,
                        onConfirm: {
                            showSheet = false
                        }
                    )
                    .presentationDetents([.fraction(0.60)])
                    .presentationDragIndicator(.visible)
                }
        .alert("Yakin batalkan?", isPresented: $isShowingCancelAlert) {
            Button("Batalkan", role: .destructive) {
                // TODO: handle cancel order action
            }
            Button("Tidak", role: .cancel) { }
        } message: {
            Text("Yakin ingin membatalkan orderan ini?")
        }
    }
  
}

#Preview {
    MainTabView()
        .environment(SessionManager.shared)
}
