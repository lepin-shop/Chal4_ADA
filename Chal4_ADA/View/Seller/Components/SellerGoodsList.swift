//
//  SellerGoodsList.swift
//  Chal4_ADA
//
//  Created by Filipus Darren Siswanto on 11/07/26.
//

import SwiftUI
import SwiftData

enum SellerListFilter: String, CaseIterable {
    case dijual = "Dijual"
    case dipesan = "Dipesan"
    case selesai = "Selesai"
}

struct SellerGoodsList: View {
    @ObservedObject private var router = AppRouter.shared
    @State private var filter: SellerListFilter = .dijual
    @State private var period: String = "Hari ini"
    
    @Query var items: [Item]
    @Query var orders: [Order]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Daftar Jualan")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Menu {
                    Button("Hari ini") { period = "Hari ini" }
                    Button("Minggu ini") { period = "Minggu ini" }
                    Button("Bulan ini") { period = "Bulan ini" }
                } label: {
                    HStack(spacing: 4) {
                        Text(period)
                        Image(systemName: "chevron.up.chevron.down")
                    }
                    .font(.headline)
                    .foregroundStyle(.accents)
                }
            }
            
            Picker("Filter Jualan", selection: $filter) {
                ForEach(SellerListFilter.allCases, id: \.self) { item in
                    Text(item.rawValue).tag(item)
                }
            }
            .pickerStyle(.segmented)
            
            LazyVStack(spacing: 16) {
                if filter == .dijual {
                    let itemGoods: [Item] = currentItems.compactMap { $0 as? Item }
                    ForEach(itemGoods) { item in
                        Button {
                            router.push(.sellerGoodDetail(item: item))
                        } label: {
                            SellerItemCard(
                                item: item
                            )
                        }
                        .buttonStyle(.plain)
                    }
                } else {
//                    let orderGoods: [Order] = currentItems.compactMap { $0 as? Order }
//                    ForEach(orderGoods) { order in
//                        Button {
//                            router.push(.sellerGoodDetail(item: item))
//                        } label: {
//                            SellerItemCard(
//                                item: item
//                            )
//                        }
//                        .buttonStyle(.plain)
//                    }

                }
            }
        }
    }
    
    // MARK: - Sample data (sementara, sampai terhubung ke data asli)
    
    private var currentItems: [Any] {
        switch filter {
        case .dijual: return items.filter { $0.seller.id.uuidString == SessionManager.shared.activeUserID && $0.status == .onSale}
        case .dipesan: return orders.filter { $0.item.seller.id.uuidString == SessionManager.shared.activeUserID && $0.status == .inProgress}
            case .selesai: return orders.filter { $0.item.seller.id.uuidString == SessionManager.shared.activeUserID && $0.status == .done}}
    }
}

//struct SellerGood: Identifiable, Hashable {
//    let id = UUID()
//    let image: ImageResource
//    let grade: String
//    let title: String
//    let stock: Int
//    let price: String
//    let pickupLimit: String
//    let pickupBefore: String
//    let description: String
//    
//    static func == (lhs: SellerGood, rhs: SellerGood) -> Bool { lhs.id == rhs.id }
//    func hash(into hasher: inout Hasher) { hasher.combine(id) }
//    
//    static let dijual: [SellerGood] = [
//        .init(image: .semangka1, grade: "Grade B", title: "Semangka Swedia", stock: 8, price: "Rp. 8.000", pickupLimit: "Batas ambil maks. 20.00", pickupBefore: "Jemput sebelum 20.00", description: "Buah semangka ada bopeng dikit di beberapa bagian, ukuran besar, 1 buah bisa 3-4 kg, enak buat isi buah atau makanan penutup, tinggal dipetik langsung. Bopeng-nya bopeng karena sedang mateng banget.\n\nBoleh nego kalau beli banyak."),
//        .init(image: .banana1, grade: "Grade B", title: "Pisang Ripe", stock: 4, price: "Rp. 5.000", pickupLimit: "Batas ambil maks. 20.00", pickupBefore: "Jemput sebelum 20.00", description: "Pisang sudah matang sempurna, manis dan legit. Cocok untuk digoreng, dibuat kolak, atau dimakan langsung. Stok terbatas.\n\nBoleh nego kalau beli banyak."),
//        .init(image: .kentang1, grade: "Grade B", title: "Mangga Kalteng", stock: 12, price: "Rp. 12.000", pickupLimit: "Batas ambil maks. 20.00", pickupBefore: "Jemput sebelum 20.00", description: "Mangga harum manis dari Kalimantan Tengah, daging tebal dan tidak berserat. Ada sedikit bopeng di kulit tapi rasa tetap juara.\n\nBoleh nego kalau beli banyak."),
//    ]
//    
//    static let dipesan: [SellerGood] = [
//        .init(image: .banana, grade: "Grade A", title: "Pisang Ripe", stock: 2, price: "Rp. 5.000", pickupLimit: "Batas ambil maks. 20.00", pickupBefore: "Jemput sebelum 20.00", description: "Pisang grade A, mulus dan matang merata. Sudah dipesan pembeli, tinggal menunggu jemput.\n\nBoleh nego kalau beli banyak."),
//    ]
//    
//    static let selesai: [SellerGood] = [
//        .init(image: .kentang1, grade: "Grade B", title: "Kentang Dieng", stock: 0, price: "Rp. 10.000", pickupLimit: "Batas ambil maks. 20.00", pickupBefore: "Jemput sebelum 20.00", description: "Kentang segar dari dataran tinggi Dieng, cocok untuk digoreng maupun direbus. Transaksi sudah selesai.\n\nBoleh nego kalau beli banyak."),
//    ]
//}
