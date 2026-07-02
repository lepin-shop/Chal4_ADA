import SwiftUI

struct ContentView: View {
    @EnvironmentObject var historyStore: HistoryStore

    @State private var showCamera = false
    @State private var showGallery = false
    @State private var capturedImage: UIImage?
    @State private var showResult = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Food Freshness Checker")
                    .font(.title2).bold()
                    .padding(.top)

                HStack(spacing: 16) {
                    Button {
                        showCamera = true
                    } label: {
                        Label("Ambil Foto", systemImage: "camera.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)

                    Button {
                        showGallery = true
                    } label: {
                        Label("Galeri", systemImage: "photo.on.rectangle")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)

                Divider().padding(.vertical, 8)

                Text("Riwayat")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                if historyStore.entries.isEmpty {
                    Spacer()
                    Text("Belum ada riwayat pengecekan")
                        .foregroundColor(.secondary)
                    Spacer()
                } else {
                    List(historyStore.entries) { entry in
                        HStack {
                            if let img = historyStore.image(for: entry) {
                                Image(uiImage: img)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                                    .clipped()
                            }
                            VStack(alignment: .leading) {
                                Text(entry.foodType).bold()
                                Text(entry.freshness)
                                    .foregroundColor(entry.freshness == "Fresh" ? .green : .red)
                                    .font(.caption)
                            }
                            Spacer()
                            Text(String(format: "%.0f%%", entry.confidence))
                                .foregroundColor(.secondary)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .sheet(isPresented: $showCamera) {
                ImagePicker(sourceType: .camera) { image in
                    capturedImage = image
                    showResult = true
                }
            }
            .sheet(isPresented: $showGallery) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    capturedImage = image
                    showResult = true
                }
            }
            .navigationDestination(isPresented: $showResult) {
                if let image = capturedImage {
                    ResultView(image: image)
                        .environmentObject(historyStore)
                }
            }
        }
    }
}
