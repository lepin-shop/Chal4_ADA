//
//  TemporaryImagePosts.swift
//  Chal4_ADA
//
//  Created by Danniel on 14/07/26.
//

import SwiftUI

@Observable
final class TemporaryImagePosts {
    static var shared = TemporaryImagePosts()
    
    var image1: UIImage?
    var image2: UIImage?
    var image3: UIImage?
    var image4: UIImage?
    
    var taken: Bool = false
    var label: QualityGrade = .fresh
    
    private init () {
        
    }
    
    func reset() {
        image1 = nil
        image2 = nil
        image3 = nil
        image4 = nil
    }
}
