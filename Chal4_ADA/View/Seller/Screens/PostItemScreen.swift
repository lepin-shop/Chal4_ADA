//
//  PostScreen.swift
//  Chal4_ADA
//
//  Created by Danniel on 07/07/26.
//

import SwiftUI

struct PostItemScreen: View {
    @State private var isGalleryPresented: Bool = false
    @State private var isCameraPresented: Bool = false
    @State var image: Image? = Image("placeholder")
    
    @State private var productName: String = ""
    @State private var quantityText: String = ""
    @State private var priceText: String = ""
    @State private var description: String = ""
    
    @State private var pickupDate: Date = .now

    @State private var pickupLocation = "Pasar Modern BSD"
    @State private var isLocationSheetPresented: Bool = false
    @State private var isRecipientSheetPresented: Bool = false

    @State private var unit: String = "Label"
    @Environment(\.dismiss) private var dismiss
    
    func cantSubmit () -> Bool {
        // TODO: Give your logic here
        return false
    }
    
    private var photoPicker: some View {
        HStack{
            Spacer()
            VStack (spacing: 16) {
                Image(systemName: "person.crop.square.badge.camera.fill")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.5)
                    .frame(width: 75, height: 65)
                    .offset(x: 10, y: 8) 

                Button {
                    isCameraPresented = true
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
        .padding(.vertical, 2)
    }

    // Tips pengambilan foto
    private var tipsBanner: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "lightbulb.max.fill")
                .foregroundStyle(.accents)
                .frame(width: 40, height: 40)
                .background(Color.accents.opacity(0.15), in: Circle())

            Text("Pengambilan foto dilakukan dari 4 sisi, pastikan pencahayaan bagus ya!")
                .font(.subheadline)
                .foregroundStyle(.primary)

            Spacer()
        }
        .padding(14)
        .background(.white, in: RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 18)
    }

    private var detailHeader: some View {
        HStack {
            Text("Detail Produk")
                .font(.title2.bold())

            Spacer()
        }
        .padding(.horizontal, 18)
    }

    private var detailForm: some View {
        Form {
            Section {
                TextField("Nama Produk", text: $productName)
                    .accessibilityLabel("Nama Produk")

                HStack {
                    TextField("Jumlah", text: $quantityText)
                        .keyboardType(.numberPad)
                        .accessibilityLabel("Jumlah")

                    Menu {
                        Button("kg") { unit = "kg" }
                        Button("gram") { unit = "gram" }
                        Button("ikat") { unit = "ikat" }
                        Button("buah") { unit = "buah" }
                    } label: {
                        HStack(spacing: 4) {
                            Text(unit)
                            Image(systemName: "chevron.up.chevron.down")
                        }
                        .foregroundStyle(.primary)
                    }
                    .tint(Color(.tertiaryLabel))
                    .accessibilityLabel("Satuan jumlah")
                    .listRowSeparator(.visible) 
                }

                TextField("Harga", text: $priceText)
                    .keyboardType(.numberPad)
                    .accessibilityLabel("Harga")

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

                // Ketuk untuk membuka sheet ubah lokasi jemput.
                Button {
                    isLocationSheetPresented = true
                } label: {
                    HStack {
                        Text("Lokasi Jemput")
                            .foregroundStyle(.primary)
                        Spacer()
                        Text(pickupLocation)
                            .foregroundStyle(.secondary)
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain) 
                .accessibilityLabel("Ubah lokasi jemput")
            }
        }
        .contentMargins(.top, 0, for: .scrollContent)
    }

    var body: some View {
        VStack (spacing: 16) {
            photoPicker

            tipsBanner

            detailHeader

            detailForm

            Spacer()
        }
        .sheet(isPresented: $isGalleryPresented) {
            ImagePickerSheet(image: self.$image)
        }
        .fullScreenCover(isPresented: $isCameraPresented) {
            CameraCaptureScreen(onComplete: { images in
                // Pakai foto pertama sebagai preview produk untuk sementara.
                if let first = images.first {
                    image = Image(uiImage: first)
                }
            })
        }
        .sheet(isPresented: $isLocationSheetPresented) {
            PickupLocationSheet(location: $pickupLocation)
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $isRecipientSheetPresented) {
            PostRecipientSheet(onDone: {
                AppRouter.shared.push(.postSuccess)
            })
            .presentationDragIndicator(.visible)
        }
        .navigationTitle("Tambah Jualan")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // Poin 1: tombol back ke screen sebelumnya (EmptyGoodsScreen)
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.semibold)
                }
                .tint(.primary)
            }
            
            // Poin 2: tombol lanjut hijau di kanan atas
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                    isRecipientSheetPresented = true
                } label: {
                    Image(systemName: "arrow.up")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .tint(.accents)
                .disabled(cantSubmit())
            }
        }
        .background(Color.background)
    }
}
