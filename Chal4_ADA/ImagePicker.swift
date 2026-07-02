import SwiftUI
import UIKit

// SwiftUI tidak punya komponen kamera/galeri bawaan, jadi kita "bungkus" (wrap)
// UIImagePickerController milik UIKit supaya bisa dipakai di dalam SwiftUI.
// Satu struct ini dipakai untuk DUA keperluan: buka kamera ATAU buka galeri,
// tergantung nilai "sourceType" yang dikirim dari pemanggilnya.
struct ImagePicker: UIViewControllerRepresentable {
    let sourceType: UIImagePickerController.SourceType   // .camera atau .photoLibrary
    let onImagePicked: (UIImage) -> Void                 // dipanggil setelah user selesai memilih/memotret foto
    @Environment(\.dismiss) private var dismiss

    // Membuat instance UIImagePickerController saat sheet ini pertama kali muncul
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator   // Coordinator di bawah yang akan "mendengarkan" hasilnya
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // Coordinator = perantara yang menerima callback dari UIImagePickerController (komponen UIKit lama)
    // dan meneruskannya ke closure "onImagePicked" (gaya SwiftUI)
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        // Dipanggil saat user selesai memotret foto ATAU memilih foto dari galeri
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.onImagePicked(image)   // kirim foto yang dipilih ke ContentView
            }
            parent.dismiss()   // tutup sheet kamera/galeri
        }

        // Dipanggil kalau user menekan "Cancel" tanpa memilih foto
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}
