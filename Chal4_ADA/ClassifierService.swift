import Vision
import CoreML
import UIKit

// Struct sederhana untuk menampung hasil klasifikasi setelah diproses model
struct ClassificationResult {
    let foodType: String     // contoh: "Apple"
    let freshness: String    // "Fresh" atau "Rotten"
    let confidence: Double   // dalam persen, contoh: 92.5
}

// Kelas ini adalah "jembatan" antara model Create ML kamu dengan aplikasi.
// Tugasnya: terima 1 foto -> jalankan lewat model -> kembalikan hasil klasifikasi.
class ClassifierService {

    // Load model .mlmodel sekali saja saat ClassifierService dibuat.
    // Nama class "Chal4_1Model" otomatis di-generate Xcode dari file Chal4_1Model.mlmodel
    private let model: VNCoreMLModel? = {
        guard let mlModel = try? Chal4_1model(configuration: MLModelConfiguration()).model,
              let vnModel = try? VNCoreMLModel(for: mlModel) else {
            return nil   // kalau model gagal di-load, nanti classify() akan return nil
        }
        return vnModel
    }()

    // Fungsi utama: input UIImage, output ClassificationResult lewat completion handler
    // (pakai completion handler karena proses klasifikasi berjalan di background thread)
    func classify(image: UIImage, completion: @escaping (ClassificationResult?) -> Void) {
        guard let model = model, let cgImage = image.cgImage else {
            completion(nil)
            return
        }

        // VNCoreMLRequest = request Vision framework untuk menjalankan model Core ML pada sebuah gambar
        let request = VNCoreMLRequest(model: model) { request, error in
            // Hasil klasifikasi berupa list kemungkinan label beserta confidence-nya,
            // diurutkan dari yang paling yakin -> kita ambil yang paling atas (top result)
            guard let results = request.results as? [VNClassificationObservation],
                  let top = results.first else {
                DispatchQueue.main.async { completion(nil) }
                return
            }

            // Label dari model berupa gabungan seperti "Fresh_Apple", perlu dipecah dulu
            let parsed = self.parseLabel(top.identifier)
            let result = ClassificationResult(
                foodType: parsed.foodType,
                freshness: parsed.freshness,
                confidence: Double(top.confidence) * 100   // confidence asli 0.0-1.0, dikonversi ke persen
            )
            // Balik ke main thread karena hasil ini dipakai untuk update UI
            DispatchQueue.main.async { completion(result) }
        }
        request.imageCropAndScaleOption = .centerCrop   // crop bagian tengah foto sesuai input size model

        // Handler yang benar-benar menjalankan request di atas terhadap gambar yang diberikan
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        // Dijalankan di background thread supaya UI tidak freeze saat model memproses gambar
        DispatchQueue.global(qos: .userInitiated).async {
            try? handler.perform([request])
        }
    }

    // Memecah label gabungan seperti "Fresh_Apple" atau "Rotten_Banana"
    // menjadi dua bagian terpisah: freshness ("Fresh") dan foodType ("Apple")
    private func parseLabel(_ label: String) -> (freshness: String, foodType: String) {
        let parts = label.split(separator: "_", maxSplits: 1)
        if parts.count == 2 {
            return (String(parts[0]), String(parts[1]))
        }
        return ("Unknown", label)   // fallback kalau format label ternyata beda
    }
}
