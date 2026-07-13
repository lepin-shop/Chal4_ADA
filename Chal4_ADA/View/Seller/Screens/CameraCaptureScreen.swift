//
//  CameraCaptureScreen.swift
//  Chal4_ADA
//
//  Created by Danniel on 12/07/26.
//

import SwiftUI
@preconcurrency import AVFoundation

// MARK: - Camera session model

@Observable
final class CameraModel {
    nonisolated let session = AVCaptureSession()

    nonisolated private let output = AVCapturePhotoOutput()
    nonisolated private let sessionQueue = DispatchQueue(label: "chal4.camera.session")
    var isAuthorized = false

    func start() async {
        await requestAccess()
        guard isAuthorized else { return }
        startSession()
    }

    nonisolated func capturePhoto() async -> UIImage? {
        await withCheckedContinuation { (continuation: CheckedContinuation<UIImage?, Never>) in
            let delegate = PhotoCaptureDelegate { image in
                continuation.resume(returning: image)
            }
            // Delegate menahan dirinya sendiri sampai callback capture selesai
            // (lihat PhotoCaptureDelegate.selfRef), jadi aman meski output tidak.
            sessionQueue.async { [output] in
                output.capturePhoto(with: AVCapturePhotoSettings(), delegate: delegate)
            }
        }
    }

    nonisolated func stop() {
        sessionQueue.async { [session] in
            if session.isRunning { session.stopRunning() }
        }
    }

    // MARK: - Private

    private func requestAccess() async {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            isAuthorized = true
        case .notDetermined:
            isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
        default:
            isAuthorized = false
        }
    }

    nonisolated private func startSession() {
        sessionQueue.async { [session, output] in
            if session.inputs.isEmpty {
                session.beginConfiguration()
                session.sessionPreset = .photo

                if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
                   let input = try? AVCaptureDeviceInput(device: device),
                   session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                session.commitConfiguration()
            }
            if !session.isRunning { session.startRunning() }
        }
    }
}

private final class PhotoCaptureDelegate: NSObject, AVCapturePhotoCaptureDelegate, @unchecked Sendable {
    private let completion: @Sendable (UIImage?) -> Void

    /// Referensi ke diri sendiri agar delegate tetap hidup sampai callback
    /// capture selesai — AVCapturePhotoOutput tidak selalu andal menahannya.
    private var selfRef: PhotoCaptureDelegate?

    nonisolated init(completion: @escaping @Sendable (UIImage?) -> Void) {
        self.completion = completion
        super.init()
        self.selfRef = self
    }

    nonisolated func photoOutput(_ output: AVCapturePhotoOutput,
                                 didFinishProcessingPhoto photo: AVCapturePhoto,
                                 error: Error?) {
        let image = photo.fileDataRepresentation().flatMap { UIImage(data: $0) }
        completion(image)
        selfRef = nil // lepaskan diri setelah selesai
    }
}

// MARK: - Live preview

struct CameraPreview: UIViewRepresentable {
    let session: AVCaptureSession

    func makeUIView(context: Context) -> PreviewView {
        let view = PreviewView()
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        return view
    }

    func updateUIView(_ uiView: PreviewView, context: Context) {}

    final class PreviewView: UIView {
        override class var layerClass: AnyClass { AVCaptureVideoPreviewLayer.self }
        var videoPreviewLayer: AVCaptureVideoPreviewLayer { layer as! AVCaptureVideoPreviewLayer }
    }
}

// MARK: - Focus frame (corner brackets)

struct FocusFrameShape: Shape {
    var corner: CGFloat = 34
    var radius: CGFloat = 28

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let r = radius

        path.move(to: CGPoint(x: rect.minX, y: rect.minY + r + corner))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + r))
        path.addArc(center: CGPoint(x: rect.minX + r, y: rect.minY + r),
                    radius: r, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX + r + corner, y: rect.minY))

        path.move(to: CGPoint(x: rect.maxX - r - corner, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - r, y: rect.minY + r),
                    radius: r, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + r + corner))

        path.move(to: CGPoint(x: rect.maxX, y: rect.maxY - r - corner))
        path.addArc(center: CGPoint(x: rect.maxX - r, y: rect.maxY - r),
                    radius: r, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX - r - corner, y: rect.maxY))

        path.move(to: CGPoint(x: rect.minX + r + corner, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.minX + r, y: rect.maxY - r),
                    radius: r, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - r - corner))

        return path
    }
}

func imagesStored (images: [UIImage]) {
    print("halo")
    TemporaryImagePosts.shared.image1 = images[0]
    TemporaryImagePosts.shared.image2 = images[1]
    TemporaryImagePosts.shared.image3 = images[2]
    TemporaryImagePosts.shared.image4 = images[3]
}

// MARK: - Screen
struct CameraCaptureScreen: View {
    var onComplete: ([UIImage]) -> Void = imagesStored

    @Environment(\.dismiss) private var dismiss
    @State private var camera = CameraModel()
    @State private var captured: [UIImage] = []
    @State private var isCapturing = false
    @State private var showConfirmation = false

    private let stepLabels = [
        "Foto bagian depan buah",
        "Foto bagian belakang buah",
        "Foto bagian atas buah",
        "Foto bagian bawah buah",
    ]

    /// Label singkat untuk tiap foto di layar konfirmasi.
    private let shortLabels = ["Depan", "Belakang", "Atas", "Bawah"]

    var body: some View {
        Group {
            if showConfirmation {
                PhotoConfirmationScreen(
                    photos: captured,
                    labels: shortLabels,
                    onContinue: {
                        Task {
                            onComplete(captured)
                            TemporaryImagePosts.shared.label = try await ImageClassifier.shared.classify(ImageRenderer(content: Image(.banana)).uiImage!)
                            TemporaryImagePosts.shared.taken = true
                            dismiss()
                        }
                    },
                    onRetake: { retake() },
                    onCancel: {
                        camera.stop()
                        dismiss()
                    }
                )
            } else {
                cameraView
            }
        }
        .task {
            await camera.start()
        }
        .onDisappear {
            camera.stop()
        }
    }

    private var cameraView: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if camera.isAuthorized {
                CameraPreview(session: camera.session)
                    .ignoresSafeArea()
            } else {
                permissionFallback
            }

            overlay
        }
    }

    // MARK: - Overlay

    private var overlay: some View {
        VStack(spacing: 0) {
            topBar

            tipBanner
                .padding(.horizontal, 16)
                .padding(.top, 8)

            Spacer()

            if camera.isAuthorized {
                FocusFrameShape()
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .frame(width: 240, height: 240)
            }

            Spacer()

            stepIndicator
                .padding(.bottom, 6)

            Text(stepLabels[min(captured.count, stepLabels.count - 1)])
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.white)
                .padding(.bottom, 20)

            shutterButton
                .padding(.bottom, 30)
        }
    }

    private var topBar: some View {
        ZStack {
            Text("Ambil foto jualan")
                .font(.headline)
                .foregroundStyle(.white)

            HStack {
                Button {
                    camera.stop()
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(10)
                        .background(.ultraThinMaterial, in: Circle())
                }
                .accessibilityLabel("Tutup")

                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    private var tipBanner: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "lightbulb.max.fill")
            Text("Pastikan pencahayaan baik supaya hasil analisa produk lebih maksimal")
                .font(.caption)
            Spacer(minLength: 0)
        }
        .foregroundStyle(.white)
        .padding(10)
        .background(Color("PickupGold").opacity(0.85), in: RoundedRectangle(cornerRadius: 14))
    }

    private var stepIndicator: some View {
        HStack(spacing: 6) {
            ForEach(1...stepLabels.count, id: \.self) { step in
                stepCircle(step)
                if step < stepLabels.count {
                    Rectangle()
                        .fill(Color.white.opacity(0.5))
                        .frame(width: 18, height: 1.5)
                }
            }
        }
    }

    private func stepCircle(_ step: Int) -> some View {
        let reached = step <= captured.count + 1
        return Text("\(step)")
            .font(.caption.bold())
            .foregroundStyle(reached ? .black : .white)
            .frame(width: 26, height: 26)
            .background(
                Circle().fill(reached ? Color.white : Color.white.opacity(0.25))
            )
    }

    private var shutterButton: some View {
        Button {
            Task { await capture() }
        } label: {
            ZStack {
                Circle()
                    .stroke(.white, lineWidth: 4)
                    .frame(width: 74, height: 74)
                Circle()
                    .fill(.white)
                    .frame(width: 60, height: 60)
            }
        }
        .disabled(isCapturing || !camera.isAuthorized)
        .opacity(camera.isAuthorized ? 1 : 0.4)
        .accessibilityLabel("Ambil foto")
    }

    private var permissionFallback: some View {
        VStack(spacing: 12) {
            Image(systemName: "camera.fill")
                .font(.largeTitle)
                .foregroundStyle(.white)
            Text("Izin kamera diperlukan")
                .font(.headline)
                .foregroundStyle(.white)
            Text("Aktifkan akses kamera di Pengaturan untuk mengambil foto produk.")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.8))
                .multilineTextAlignment(.center)
            Button("Buka Pengaturan") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.accents)
            .padding(.top, 4)
        }
        .padding(32)
    }

    // MARK: - Actions

    private func capture() async {
        guard !isCapturing else { return }
        isCapturing = true
        if let image = await camera.capturePhoto() {
            captured.append(image)
        }
        isCapturing = false

        if captured.count >= stepLabels.count {
            camera.stop()
            showConfirmation = true
        }
    }

    private func retake() {
        captured.removeAll()
        showConfirmation = false
        Task { await camera.start() }
    }
}
