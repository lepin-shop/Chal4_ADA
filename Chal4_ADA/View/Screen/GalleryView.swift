//
//  GalleryView.swift
//  Chal4_ADA
//
//  Created by Danniel on 02/07/26.
//

import SwiftUI
import PhotosUI

struct GalleryView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var uiImage: UIImage?

    var body: some View {
        VStack {
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }
            PhotosPicker("Pick a photo", selection: $selectedItem, matching: .images)
        }
        .onChange(of: selectedItem) { _, newItem in   // two-param closure is iOS 17+
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let img = UIImage(data: data) {
                    uiImage = img
                }
            }
        }
    }
    
    
}

#Preview {
    GalleryView()
}
