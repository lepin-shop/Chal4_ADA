//
//  HomeView.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 02/07/26.
//

import Foundation
import SwiftUI
import SwiftData

struct BuyerScreen: View {
    @State private var selectedItem: Item? = nil
    @State private var searchText: String = ""
    @ObservedObject private var router = AppRouter.shared
    
    // Ye ye ye ini tidak sebagus predicate but this is 1 am fuck it we balls
    @Query var items: [Item]
    
    private var emptyState: EmptyState = EmptyState(icon: "cart.badge.questionmark", message: "Belum ada mitra yang posting produk untuk kamu")
    
    private var browsableItems: [Item] {
        guard let currentUserID = SessionManager.shared.activeUserID else { return items
        }
        return items.filter { $0.seller.id.uuidString != currentUserID }
    }
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack (path: $router.path){
            VStack(spacing: 0) {
                heroHeader.padding(.bottom, 16)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(browsableItems) { item in
                            Button(action: {
                                router.push(Route.itemDetail(item: item))
                            }) {
                                ProductGridCard(item: item)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cart", systemImage: "cart", action: {
                        router.push(Route.orders)
                    })
                    .tint(.primary)
                }
            }
            .navigationDestination(for: Route.self) { route in
                RouteDestinationView(route: route)
            }
            
        }
    }
    
    private var heroHeader: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .top) {
                Text("Dari sisa jadi\nbahas usaha")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(.white)
                    .lineLimit(2)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass").foregroundStyle(.gray).font(.system(size: 18, weight: .semibold))
                TextField("Cari buah grade B", text: $searchText).font(.subheadline)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .clipShape(Capsule())
            .glassEffect()
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        .background(
            ZStack(alignment: .bottomTrailing) {
                Color(red: 0.35, green: 0.55, blue: 0.40)
                Image("CharacterHeader")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 180)
                    .offset(x: -50, y: 0)
            }
                .clipShape(
                    .rect(
                        bottomLeadingRadius: 32,
                        bottomTrailingRadius: 32,
                    )
                )
                .ignoresSafeArea(edges: .top)
        )
        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    MainTabView()
        .environment(SessionManager.shared)
        .modelContainer(AppContainer.shared.modelContainer)
}
