//
//  PostScreen.swift
//  Chal4_ADA
//
//  Created by Danniel on 07/07/26.
//

import SwiftUI

struct PostItemScreen: View {
    @State private var isGalleryPresented: Bool = false
    @State var image: Image? = Image("placeholder")
    
    @State private var productName: String = ""
    @State private var quantityText: String = ""
    @State private var priceText: String = ""
    @State private var description: String = ""
    
    @State private var pickupDate: Date = .now
    
    private let pickupLocation = "Pasar Modern BSD"
    
    func cantSubmit () -> Bool {
        // TODO: Give your logic here
        return false
    }
    
    var body: some View {
        VStack (spacing: 16) {
            HStack {
                Spacer()
                VStack (spacing: 16) {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.5)
                        .frame(width: 75, height: 65)
                    
                    Button {
                        isGalleryPresented = true
                    } label: {
                        Text("Ambil & cek foto produk")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 16)
                    }
                    .glassEffect(.regular.tint(.blue))
        
                }
                
                Spacer()
            }
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .strokeBorder(
                        style: StrokeStyle(lineWidth: 1.5, dash: [6, 4])
                    )
                    .foregroundColor(.gray.opacity(0.5))
                    .background(.white, in: RoundedRectangle(cornerRadius: 24))
            )
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            
            HStack {
                Text("Detail Produk")
                    .font(.title2.bold())
                
                Spacer()
            }
            .padding(.horizontal, 18)
            
            Form {
                Section {
                    TextField("Nama Produk", text: $productName)
                        .accessibilityLabel("Nama Produk")
                    
                    TextField("Jumlah (kg)", text: $quantityText)
                        .keyboardType(.numberPad)
                        .accessibilityLabel("Jumlah")
                    
                    HStack(spacing: 4) {
                        Text("Rp.")
                            .foregroundStyle(.secondary)
                        TextField("Harga", text: $priceText)
                            .keyboardType(.numberPad)
                        Text("/kg")
                            .foregroundStyle(.secondary)
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Harga per kilogram")
                    
                    TextField("Deskripsi (Opsional)", text: $description, axis: .vertical)
                        .lineLimit(1...4)
                        .accessibilityLabel("Deskripsi")
                }
                
                Section {
                    // Native compact DatePicker: passing both .date and
                    // .hourAndMinute automatically renders as two separate
                    // pill controls, matching the screenshot with zero
                    // custom styling.
                    DatePicker(
                        "Waktu Jemput",
                        selection: $pickupDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.compact)
                    
                    // Static, non-interactive per instructions.
                    HStack {
                        Text("Lokasi Jemput")
                        Spacer()
                        Text(pickupLocation)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .contentMargins(.top, 0, for: .scrollContent)
            
            Spacer()
        }
        .sheet(isPresented: $isGalleryPresented) {
            ImagePickerSheet(image: self.$image)
        }
        .navigationTitle("Tambah Dagangan")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(role: .confirm, action: {})
                .tint(.blue)
                .disabled(cantSubmit())
        }
        .background(Color.background)
    }
}

#Preview {
    NavigationStack {
        PostItemScreen()
    }
}

#Preview {
    MainTabView()
}
