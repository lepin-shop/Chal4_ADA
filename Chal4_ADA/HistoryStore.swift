import Foundation
import UIKit
import Combine

// Kelas ini bertugas menyimpan & memuat riwayat pengecekan secara PERMANEN di device
// (jadi kalau app ditutup lalu dibuka lagi, riwayatnya tidak hilang).
// ObservableObject supaya SwiftUI otomatis update tampilan setiap kali "entries" berubah.
class HistoryStore: ObservableObject {
    @Published var entries: [HistoryEntry] = []   // daftar riwayat yang ditampilkan di Home Screen

    // Lokasi file JSON tempat menyimpan daftar riwayat (metadata: nama file, label, confidence, dll)
    private let entriesFileURL: URL = {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return dir.appendingPathComponent("history.json")
    }()

    // Folder khusus untuk menyimpan file-file foto hasil pengecekan
    private var imagesDirectory: URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("HistoryImages")
        if !FileManager.default.fileExists(atPath: dir.path) {
            try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        }
        return dir
    }

    // Saat app dibuka, langsung coba load riwayat yang sudah pernah tersimpan
    init() {
        load()
    }

    // Dipanggil setiap kali ada hasil klasifikasi baru (dari ResultView)
    // Fungsinya: 1) simpan foto ke folder HistoryImages, 2) tambahkan data ke list "entries"
    func addEntry(image: UIImage, foodType: String, freshness: String, confidence: Double) {
        let fileName = "\(UUID().uuidString).jpg"
        let fileURL = imagesDirectory.appendingPathComponent(fileName)
        if let data = image.jpegData(compressionQuality: 0.8) {
            try? data.write(to: fileURL)   // simpan foto sebagai file .jpg di storage app
        }
        let entry = HistoryEntry(imageFileName: fileName, foodType: foodType, freshness: freshness, confidence: confidence)
        entries.insert(entry, at: 0)   // entry terbaru ditaruh paling atas
        save()
    }

    // Ambil kembali foto dari storage berdasarkan nama file yang tersimpan di satu entry
    // Dipakai untuk menampilkan thumbnail di list riwayat
    func image(for entry: HistoryEntry) -> UIImage? {
        let fileURL = imagesDirectory.appendingPathComponent(entry.imageFileName)
        return UIImage(contentsOfFile: fileURL.path)
    }

    // Tulis seluruh isi "entries" ke file history.json (dipanggil setiap ada perubahan)
    private func save() {
        if let data = try? JSONEncoder().encode(entries) {
            try? data.write(to: entriesFileURL)
        }
    }

    // Baca file history.json saat app pertama kali dibuka, kalau ada isinya masukkan ke "entries"
    private func load() {
        guard let data = try? Data(contentsOf: entriesFileURL),
              let decoded = try? JSONDecoder().decode([HistoryEntry].self, from: data) else { return }
        entries = decoded
    }
}
