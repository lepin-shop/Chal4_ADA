import SwiftUI

// Layar hasil klasifikasi: tampilkan foto, jalankan model, lalu tampilkan hasilnya
struct ResultView: View {
    let image: UIImage
    @EnvironmentObject var historyStore: HistoryStore
    @Environment(\.dismiss) private var dismiss

    @State private var result: ClassificationResult?
    @State private var isLoading = true
    private let classifier = ClassifierService()

    var body: some View {
        VStack(spacing: 20) {
            // Preview foto yang baru difoto/dipilih
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 320)
                .cornerRadius(12)
                .padding(.top)

            if isLoading {
                ProgressView("Menganalisis...")   // ditampilkan selagi model masih memproses
            } else if let result = result {
                // Tampilan hasil: jenis buah, status fresh/rotten, dan confidence
                VStack(spacing: 8) {
                    Text(result.foodType)
                        .font(.title2).bold()

                    Text(result.freshness)
                        .font(.headline)
                        .foregroundColor(result.freshness == "Fresh" ? .green : .red)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .background((result.freshness == "Fresh" ? Color.green : Color.red).opacity(0.15))
                        .cornerRadius(20)

                    Text(String(format: "Confidence: %.1f%%", result.confidence))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            } else {
                // Ditampilkan kalau model gagal load/klasifikasi
                Text("Gagal menganalisis gambar. Pastikan model sudah ditambahkan ke project.")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            }

            Spacer()

            Button("Selesai") {
                dismiss()   // balik ke Home Screen
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
        }
        .padding()
        .onAppear {
            // Otomatis jalan begitu layar ini muncul: klasifikasi foto, lalu simpan ke riwayat
            classifier.classify(image: image) { classificationResult in
                self.result = classificationResult
                self.isLoading = false
                if let r = classificationResult {
                    historyStore.addEntry(image: image, foodType: r.foodType, freshness: r.freshness, confidence: r.confidence)
                }
            }
        }
    }
}
