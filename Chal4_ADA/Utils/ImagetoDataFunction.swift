//
//  DisplayDate.swift
//  Chal4_ADA
//
//  Created by Danniel on 12/07/26.
//

import SwiftUI

func imageToData(from image: Image) -> Data? {
    let renderer = ImageRenderer(content: image)
    guard let uiImage = renderer.uiImage else { return nil }
    return uiImage.jpegData(compressionQuality: 0.8)
}
