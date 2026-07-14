//
//  PostScreen.swift
//  Chal4_ADA
//
//  Created by Danniel on 07/07/26.
//

import SwiftUI
import SwiftData

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
                if TemporaryImagePosts.shared.taken {
                    HStack (spacing: 5) {
                        Image(uiImage: TemporaryImagePosts.shared.image1!)
                            .resizable()
                            .scaledToFit()
                            .opacity(0.5)
                            .frame(width: 75, height: 65)
                            .offset(y: 8)
                        Image(uiImage: TemporaryImagePosts.shared.image2!)
                            .resizable()
                            .scaledToFit()
                            .opacity(0.5)
                            .frame(width: 75, height: 65)
                            .offset(y: 8)
                        Image(uiImage: TemporaryImagePosts.shared.image3!)
                            .resizable()
                            .scaledToFit()
                            .opacity(0.5)
                            .frame(width: 75, height: 65)
                            .offset(y: 8)
                        Image(uiImage: TemporaryImagePosts.shared.image4!)
                            .resizable()
                            .scaledToFit()
                            .opacity(0.5)
                            .frame(width: 75, height: 65)
                            .offset(y: 8)

                    }
                } else {
                    Image(systemName: "person.crop.square.badge.camera.fill")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.5)
                        .frame(width: 75, height: 65)
                        .offset(x: 10, y: 8)
                    
                }
                
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
    
    private func gradeBanner(qualityGrade: QualityGrade) -> some View {
        HStack(alignment: .center, spacing: 16) {
            HStack(spacing: 6) {
                Image(systemName: "wand.and.sparkles")
                    .font(.system(size: 15, weight: .semibold))
                Text(qualityGrade.rawValue)
                    .font(.headline.bold())
            }
            .foregroundStyle(.accents)
            .padding(.horizontal, 18)
            .padding(.vertical, 12)
            .overlay(
                Capsule()
                    .stroke(Color.accents.opacity(0.6), lineWidth: 1.5)
            )
            if qualityGrade == .fresh {
                Text("Sangat segar, dan masih baik untuk dikonsumsi langsung")
                    .font(.subheadline)
                    .foregroundStyle(.accents)
            } else if (qualityGrade == .standard) {
                Text("Cukup segar, dan masih baik untuk dikonsumsi langsung atau diolah lagi")
                    .font(.subheadline)
                    .foregroundStyle(.accents)
            } else {
                Text("Tidak layak namun dapat diolah lagi menjadi hal lain")
                    .font(.subheadline)
                    .foregroundStyle(.accents)
            }
            
            Spacer(minLength: 0)
        }
        .padding(16)
        .background(.white, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.accents.opacity(0.35), lineWidth: 1)
        )
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
        VStack(spacing: 0) {
            VStack(spacing: 16) {
                TextField("Nama Produk", text: $productName)
                    .accessibilityLabel("Nama Produk")
                
                Divider()
                
                HStack {
                    TextField("Jumlah", text: $quantityText)
                        .keyboardType(.numberPad)
                        .accessibilityLabel("Jumlah")
                }
                
                Divider()
                
                TextField("Harga", text: $priceText)
                    .keyboardType(.numberPad)
                    .accessibilityLabel("Harga")
                
                Divider()
                
                TextField("Deskripsi (Opsional)", text: $description, axis: .vertical)
                    .lineLimit(1...4)
                    .accessibilityLabel("Deskripsi")
            }
            .padding(16)
            .background(.white, in: RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 18)
            
            VStack(spacing: 16) {
                DatePicker(
                    "Jemput Sebelum",
                    selection: $pickupDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(.compact)
                
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
            .padding(16)
            .background(.white, in: RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 18)
            .padding(.top, 12)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack (spacing: 16) {
                photoPicker
                
                if TemporaryImagePosts.shared.taken {
                    gradeBanner(qualityGrade: TemporaryImagePosts.shared.label)
                } else {
                    tipsBanner
                }
                
                detailHeader
                
                detailForm
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .sheet(isPresented: $isGalleryPresented) {
            ImagePickerSheet(image: self.$image)
        }
        .fullScreenCover(isPresented: $isCameraPresented) {
            CameraCaptureScreen()
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
                    TemporaryImagePosts.shared.taken = false
                    TemporaryImagePosts.shared.reset()
                } label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.semibold)
                }
                .tint(.primary)
            }
            
            // Poin 2: tombol lanjut hijau di kanan atas
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    let image1 = imageToData(from: Image(uiImage: TemporaryImagePosts.shared.image1!))
                    let image2 = imageToData(from: Image(uiImage: TemporaryImagePosts.shared.image2!))
                    let image3 = imageToData(from: Image(uiImage: TemporaryImagePosts.shared.image3!))
                    let image4 = imageToData(from: Image(uiImage: TemporaryImagePosts.shared.image4!))

                    do {
                        try AppContainer.shared.itemService.createItem(
                            seller: SessionManager.shared.currentUser!,
                            title: self.productName,
                            description: self.description,
                            qualityGrade: TemporaryImagePosts.shared.label,
                            quantity: 10,
                            pricePerUnit: 15_000,
                            expiresAt: .now.addingTimeInterval(60 * 60 * 24 * 7),
                            imageData1: image1,
                            imageData2: image2,
                            imageData3: image3,
                            imageData4: image4,
                        )
                    } catch {
                        print(error)
                    }
                    isRecipientSheetPresented = true
                    TemporaryImagePosts.shared.taken = false
                    TemporaryImagePosts.shared.reset()
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


#Preview {
    NavigationStack {
        PostItemScreen()
    }
    .environment(SessionManager.shared)
    .modelContainer(AppContainer.shared.modelContainer)
}
