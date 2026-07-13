//
//  ImageClassifier.swift
//  Chal4_ADA
//
//  Created by Danniel on 13/07/26.
//

import SwiftUI
import UIKit
@preconcurrency import Vision
import CoreML

final class ImageClassifier {
    static let shared = ImageClassifier()

    private let model: VNCoreMLModel

    private init() {
        guard let coreModel = try? VNCoreMLModel(for: ModelClassification(configuration: MLModelConfiguration()).model) else {
            fatalError("Gagal load model")
        }
        self.model = coreModel
    }
    
    func parseLabel(_ label: String) -> QualityGrade {
        if label.hasSuffix("_segar_sedang") {
            return QualityGrade.standard
        } else if label.hasSuffix("_busuk") {
            return .rotten
        } else {
            return .fresh
        }
    }

    func classify(_ image: UIImage) async throws -> QualityGrade {
        guard let cgImage = image.cgImage else { return .fresh } // TODO: Ganti ini

        return try await withCheckedThrowingContinuation { continuation in
            let request = VNCoreMLRequest(model: model) { req, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let results = req.results as? [VNClassificationObservation],
                      let top = results.first
                else {
                    continuation.resume(returning: .fresh)
                    return
                }
                
                let parsed :QualityGrade = self.parseLabel(top.identifier)
                
                continuation.resume(returning: parsed)
            }
            
            request.imageCropAndScaleOption = .centerCrop

            let handler = VNImageRequestHandler(cgImage: cgImage)
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try handler.perform([request])
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
