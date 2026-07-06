//
//  ItemsData.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 02/07/26.
//

import Foundation

// MARK: - Sample Data
// Instantiation order matters: User → Tag → Item → Order
// Each init auto-wires its back-references, so no manual appending needed.

enum ItemsData {

    // MARK: Users

    static let budi = User(
        name: "Budi Santoso",
        phone: "081234567890",
        location: "Pasar Minggu, Jakarta Selatan"
    )

    static let siti = User(
        name: "Siti Rahayu",
        phone: "082345678901",
        location: "Depok, Jawa Barat"
    )

    static let andi = User(
        name: "Andi Wijaya",
        phone: "083456789012",
        location: "Bekasi, Jawa Barat"
    )

    // MARK: Tags (owned by budi as seller)
    // Tag.init auto-appends to owner.ownedTags

    static let tagKeluarga = Tag(owner: budi, label: "Keluarga")
    static let tagPelangganSetia = Tag(owner: budi, label: "Pelanggan Setia")

    // MARK: Items (sold by budi)
    // Item.init auto-appends to seller.items

    static let berasPremium = Item(
        seller: budi,
        title: "Beras Premium Pandan Wangi",
        description: "Beras pandan wangi kualitas premium, baru digiling. Cocok untuk konsumsi sehari-hari — tekstur pulen dan aroma harum alami.",
        mediaUrl: "photo.fill",
        qualityGrade: .A,
        quantity: 50,
        quantityAvailable: 50,
        pricePerUnit: 15_000,
        expiresAt: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
        status: .onSale
    )

    static let apelFuji = Item(
        seller: budi,
        title: "Apel Fuji Segar",
        description: "Apel Fuji renyah dan manis langsung dari kebun lokal. Bagus untuk camilan, jus, atau bahan kue. Dipanen minggu ini.",
        mediaUrl: "leaf.fill",
        qualityGrade: .B,
        quantity: 30,
        quantityAvailable: 22,
        pricePerUnit: 25_000,
        expiresAt: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
        status: .onSale
    )

    static let telurKampung = Item(
        seller: siti,
        title: "Telur Ayam Kampung",
        description: "Telur ayam kampung berukuran besar dari peternakan keluarga kecil. Kuning telur orange tua dan rasa yang lebih gurih dibanding telur biasa.",
        mediaUrl: "egg.fill",
        qualityGrade: .A,
        quantity: 15,
        quantityAvailable: 10,
        pricePerUnit: 35_000,
        expiresAt: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
        status: .onSale
    )

    static let tomat = Item(
        seller: siti,
        title: "Tomat Segar Lokal",
        description: "Tomat merah segar hasil kebun sendiri. Cocok untuk masak sambal, sop, atau dimakan langsung. Stok terbatas.",
        mediaUrl: "circle.fill",
        qualityGrade: .C,
        quantity: 20,
        quantityAvailable: 0,
        pricePerUnit: 12_000,
        expiresAt: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
        status: .soldOut
    )

    // MARK: Tag visibility
    // berasPremium hanya bisa dilihat oleh anggota tagKeluarga dan tagPelangganSetia
    // apelFuji terbuka untuk semua (tagsVisibility kosong = public)

    // MARK: Orders

    // siti membeli beras dari budi (inProgress)
    static let orderBerasSiti = Order(
        item: berasPremium,
        buyer: siti,
        quantityOrdered: 5,
        status: .inProgress,
        totalPrice: 75_000,
        location: "Pasar Minggu, Jakarta Selatan",
    )

    // andi membeli apel dari budi (done)
    static let orderApelAndi = Order(
        item: apelFuji,
        buyer: andi,
        quantityOrdered: 3,
        status: .done,
        totalPrice: 75_000,
        location: "Pasar Modern, BSD South Tangerang",
    )

    // MARK: Convenience collections

    /// Semua item yang statusnya onSale — dipakai untuk buyer home screen.
    static let activeItems: [Item] = {
        setup()
        return [berasPremium, apelFuji, telurKampung, tomat]
            .filter { $0.status == .onSale }
    }()
    
    static let activeOrders: [Order] = {
        setup()
        return [orderBerasSiti]
            .filter { $0.status == .inProgress }
    }()

    static let completedOrders: [Order] = {
        setup()
        return [orderApelAndi]
            .filter { $0.status == .done }
    }()

    // MARK: Setup
    // Memanggil semua lazy static agar graf relasi terbentuk sebelum dipakai.

    static func setup() {
        _ = tagKeluarga
        _ = tagPelangganSetia
        berasPremium.add_tag(tagKeluarga)
        berasPremium.add_tag(tagPelangganSetia)
        _ = orderBerasSiti
        _ = orderApelAndi
        budi.following.append(siti)
        siti.followers.append(budi)
    }
}
