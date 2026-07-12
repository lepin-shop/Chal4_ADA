//
//  HomeView.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 02/07/26.
//

import Foundation
import SwiftUI



struct BuyerScreen: View {
    @Environment(SessionManager.self) private var session
    @State private var selectedItem: Item? = nil
    @State private var searchText: String = ""
    @ObservedObject private var router = AppRouter.shared
    
    private var emptyState: EmptyState = EmptyState(icon: "cart.badge.questionmark", message: "Belum ada mitra yang posting produk untuk kamu")
    
    // taro ViewModel
    private let items = ItemsData.activeItems
    
    private var browsableItems: [Item] {
        guard let currentUserID = session.activeUserID else { return items }
        return items.filter { $0.seller.id.uuidString != currentUserID }
    }
    
   
    // taro viewModel
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack (path: $router.path){
            ZStack(alignment: .top) {
                Color(.systemGray6).ignoresSafeArea()
                VStack(spacing: 0) {
                    heroHeader
                    Spacer()
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16,) {
                            ForEach(browsableItems) { item in
                                Button(action: {
                                    router.push(Route.itemDetail(item: item))
                                }) {
                                    ProductGridCard(item: item)
                                        .padding(.horizontal, 6)
                                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 10)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        Spacer()
                    }
                }
                .toolbarBackground(.hidden, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Cart", systemImage: "cart", action: {
                            router.push(Route.orders)
                        })
                        .badge(3)
                        .tint(.primary)
                    }
                }
                .navigationDestination(for: Route.self) { route in
                                 RouteDestinationView(route: route)
                            }
            }
        }
    }
    
    // TODO: jadikan reusable component
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
                                Image(systemName: "mic").foregroundStyle(.gray).font(.system(size: 18, weight: .semibold))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color(.systemBackground).opacity(0.9))
            .clipShape(Capsule())
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
}
