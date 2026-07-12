//
//  SellerGoodsList.swift
//  Chal4_ADA
//
//  Created by Filipus Darren Siswanto on 11/07/26.
//

import SwiftUI

enum SellerListFilter: String, CaseIterable {
    case dijual = "Dijual"
    case dipesan = "Dipesan"
    case selesai = "Selesai"
}

struct SellerGoodsList: View {
    @ObservedObject private var router = AppRouter.shared
    @State private var filter: SellerListFilter = .dijual
    @State private var period: String = "Hari ini"

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
                ForEach(currentItems) { good in
                    Button {
                        router.push(.sellerGoodDetail(good: good))
                    } label: {
                        SellerItemCard(
                            image: good.image,
                            grade: good.grade,
                            title: good.title,
                            stock: good.stock,
                            price: good.price,
                            pickupLimit: good.pickupLimit
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    // MARK: - Sample data (sementara, sampai terhubung ke data asli)

    private var currentItems: [SellerGood] {
        switch filter {
        case .dijual: return SellerGood.dijual
        case .dipesan: return SellerGood.dipesan
        case .selesai: return SellerGood.selesai
        }
    }
}

struct SellerGood: Identifiable, Hashable {
    let id = UUID()
    let image: ImageResource
    let grade: String
    let title: String
    let stock: Int
    let price: String
    let pickupLimit: String
    let pickupBefore: String
    let description: String

    static func == (lhs: SellerGood, rhs: SellerGood) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }

    static let dijual: [SellerGood] = [
        .init(image: .watermelon, grade: "Grade B", title: "Semangka Swedia", stock: 8, price: "Rp. 8.000", pickupLimit: "Batas ambil maks. 20.00", pickupBefore: "Jemput sebelum 20.00", description: "Buah semangka ada bopeng dikit di beberapa bagian, ukuran besar, 1 buah bisa 3-4 kg, enak buat isi buah atau makanan penutup, tinggal dipetik langsung. Bopeng-nya bopeng karena sedang mateng banget.\n\nBoleh nego kalau beli banyak."),
        .init(image: .banana, grade: "Grade B", title: "Pisang Ripe", stock: 4, price: "Rp. 5.000", pickupLimit: "Batas ambil maks. 20.00", pickupBefore: "Jemput sebelum 20.00", description: "Pisang sudah matang sempurna, manis dan legit. Cocok untuk digoreng, dibuat kolak, atau dimakan langsung. Stok terbatas.\n\nBoleh nego kalau beli banyak."),
        .init(image: .potato, grade: "Grade B", title: "Mangga Kalteng", stock: 12, price: "Rp. 12.000", pickupLimit: "Batas ambil maks. 20.00", pickupBefore: "Jemput sebelum 20.00", description: "Mangga harum manis dari Kalimantan Tengah, daging tebal dan tidak berserat. Ada sedikit bopeng di kulit tapi rasa tetap juara.\n\nBoleh nego kalau beli banyak."),
    ]

    static let dipesan: [SellerGood] = [
        .init(image: .banana, grade: "Grade A", title: "Pisang Ripe", stock: 2, price: "Rp. 5.000", pickupLimit: "Batas ambil maks. 20.00", pickupBefore: "Jemput sebelum 20.00", description: "Pisang grade A, mulus dan matang merata. Sudah dipesan pembeli, tinggal menunggu jemput.\n\nBoleh nego kalau beli banyak."),
    ]

    static let selesai: [SellerGood] = [
        .init(image: .potato, grade: "Grade B", title: "Kentang Dieng", stock: 0, price: "Rp. 10.000", pickupLimit: "Batas ambil maks. 20.00", pickupBefore: "Jemput sebelum 20.00", description: "Kentang segar dari dataran tinggi Dieng, cocok untuk digoreng maupun direbus. Transaksi sudah selesai.\n\nBoleh nego kalau beli banyak."),
    ]
}

#Preview {
    ScrollView {
        SellerGoodsList()
            .padding(.horizontal, 16)
    }
    .background(Color(.systemGroupedBackground))
}
