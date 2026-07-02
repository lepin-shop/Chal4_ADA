import Foundation

// Model data untuk satu baris riwayat pengecekan (1 foto = 1 entry)
struct HistoryEntry: Identifiable, Codable {
    let id: UUID
    let imageFileName: String   // nama file foto yang disimpan di folder HistoryImages
    let foodType: String        // jenis buah/sayur hasil deteksi, contoh: "Apple"
    let freshness: String       // status kesegaran hasil deteksi: "Fresh" atau "Rotten"
    let confidence: Double      // tingkat keyakinan model dalam persen, contoh: 92.5
    let date: Date              // waktu foto diambil, otomatis diisi saat entry dibuat

    // Codable dipakai supaya struct ini bisa diubah jadi JSON dan disimpan ke file
    init(id: UUID = UUID(), imageFileName: String, foodType: String, freshness: String, confidence: Double, date: Date = Date()) {
        self.id = id
        self.imageFileName = imageFileName
        self.foodType = foodType
        self.freshness = freshness
        self.confidence = confidence
        self.date = date
    }
}
