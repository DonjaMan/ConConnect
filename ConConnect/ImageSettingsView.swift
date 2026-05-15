//
//  ImageSettingsView.swift
//  ConConnect
//
//  Created by Donald Johnson on 4/29/26.
//

import SwiftUI
import SwiftData
import PhotosUI
import UniformTypeIdentifiers

struct ImageSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ImageItem.orderIndex) private var images: [ImageItem]

    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var isLoading = false
    @State private var loadingMessage = ""
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var showFilePicker = false
    @State private var showPhotoPicker = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if images.isEmpty {
                        emptyStateView
                    } else {
                        imageGridView
                    }
                }
                
                // Loading overlay
                if isLoading {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        ProgressView()
                            .scaleEffect(1.5)
                            .tint(.white)
                        
                        Text(loadingMessage)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 40)
                            .multilineTextAlignment(.center)
                    }
                    .padding(40)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.ultraThinMaterial)
                    }
                }
            }
            .navigationTitle("Slideshow Images")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                    .disabled(isLoading)
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Button {
                            showPhotoPicker = true
                        } label: {
                            Label("Photo Library", systemImage: "photo.on.rectangle")
                        }
                        Button {
                            showFilePicker = true
                        } label: {
                            Label("Files", systemImage: "folder")
                        }
                    } label: {
                        Label("Add Images", systemImage: "plus")
                    }
                    .disabled(isLoading)
                }
            }
            .alert("Image Load Error", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .photosPicker(isPresented: $showPhotoPicker,
                          selection: $selectedItems,
                          maxSelectionCount: 10,
                          matching: .images)
            .fileImporter(
                isPresented: $showFilePicker,
                allowedContentTypes: [.image],
                allowsMultipleSelection: true
            ) { result in
                Task {
                    await loadImagesFromFiles(result: result)
                }
            }
            .onChange(of: selectedItems) { oldValue, newValue in
                Task {
                    await loadImages(from: newValue)
                }
            }
        }
    }
    
    private var emptyStateView: some View {
        ContentUnavailableView {
            Label("No Images", systemImage: "photo.on.rectangle.angled")
        } description: {
            Text("Add images from your photo library or the Files app to display in the slideshow")
        } actions: {
            HStack(spacing: 16) {
                Button {
                    showPhotoPicker = true
                } label: {
                    Label("Photo Library", systemImage: "photo.on.rectangle")
                        .font(.title3)
                        .frame(width: 165)
                }
                .buttonStyle(.borderedProminent)

                Button {
                    showFilePicker = true
                } label: {
                    Label("Files", systemImage: "folder")
                        .font(.title3)
                        .frame(width: 165)
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
    
    private var imageGridView: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 200, maximum: 300), spacing: 16)
            ], spacing: 16) {
                ForEach(Array(images.enumerated()), id: \.element.id) { index, image in
                    if let uiImage = UIImage(data: image.imageData) {
                        ImageCard(image: uiImage, index: index, totalImages: images.count) {
                            deleteImage(image)
                        } moveUp: {
                            moveImage(image, direction: -1)
                        } moveDown: {
                            moveImage(image, direction: 1)
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    private func loadImagesFromFiles(result: Result<[URL], Error>) async {
        switch result {
        case .success(let urls):
            await MainActor.run {
                isLoading = true
                loadingMessage = "Loading images..."
            }

            var successCount = 0
            var failCount = 0

            for (index, url) in urls.enumerated() {
                await MainActor.run {
                    loadingMessage = "Loading image \(index + 1) of \(urls.count)..."
                }

                guard url.startAccessingSecurityScopedResource() else {
                    failCount += 1
                    continue
                }
                defer { url.stopAccessingSecurityScopedResource() }

                do {
                    let data = try Data(contentsOf: url)
                    let success = await MainActor.run { processImageData(data) }
                    if success {
                        successCount += 1
                    } else {
                        failCount += 1
                    }
                } catch {
                    failCount += 1
                }
            }

            await MainActor.run {
                isLoading = false
                if failCount > 0 {
                    errorMessage = "\(successCount) image(s) loaded successfully.\n\(failCount) image(s) failed to load."
                    showError = true
                }
            }

        case .failure(let error):
            await MainActor.run {
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }

    private func loadImages(from items: [PhotosPickerItem]) async {
        await MainActor.run {
            isLoading = true
            loadingMessage = "Loading images..."
        }
        
        var successCount = 0
        var failCount = 0
        
        for (index, item) in items.enumerated() {
            await MainActor.run {
                loadingMessage = "Loading image \(index + 1) of \(items.count)..."
            }
            
            // Try to load the image data
            var imageData: Data?
            
            // Strategy 1: Try loading as Data directly
            do {
                if let data = try await item.loadTransferable(type: Data.self) {
                    imageData = data
                }
            } catch {
                print("⚠️ Failed to load as Data: \(error.localizedDescription)")
            }
            
            // Strategy 2: If Data fails, try using supported image types
            if imageData == nil {
                do {
                    // Try loading supported image types
                    if let data = try await item.loadTransferable(type: Data.self) {
                        imageData = data
                    }
                } catch {
                    print("⚠️ Failed to load image data: \(error.localizedDescription)")
                }
            }
            
            // Process the image data if we got it
            if let data = imageData {
                let success = await MainActor.run { processImageData(data) }
                if success {
                    successCount += 1
                } else {
                    failCount += 1
                }
            } else {
                print("❌ Could not load image - may be in iCloud and not yet downloaded")
                failCount += 1
            }
        }
        
        await MainActor.run {
            selectedItems.removeAll()
            isLoading = false
            
            // Show error if some images failed
            if failCount > 0 {
                errorMessage = "\(successCount) image(s) loaded successfully.\n\(failCount) image(s) failed to load.\n\nImages may be stored in iCloud and not yet downloaded to this device. Try downloading them first in the Photos app."
                showError = true
            }
        }
    }
    
    @MainActor
    private func processImageData(_ data: Data) -> Bool {
        guard let uiImage = UIImage(data: data) else {
            print("❌ Failed to create UIImage from data")
            return false
        }
        
        // Resize if too large (max 2048px on longest side)
        let maxDimension: CGFloat = 2048
        let resizedImage: UIImage
        
        if uiImage.size.width > maxDimension || uiImage.size.height > maxDimension {
            let ratio = min(maxDimension / uiImage.size.width, maxDimension / uiImage.size.height)
            let newSize = CGSize(width: uiImage.size.width * ratio, height: uiImage.size.height * ratio)
            
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            uiImage.draw(in: CGRect(origin: .zero, size: newSize))
            resizedImage = UIGraphicsGetImageFromCurrentImageContext() ?? uiImage
            UIGraphicsEndImageContext()
        } else {
            resizedImage = uiImage
        }
        
        // Compress to JPEG
        if let compressedData = resizedImage.jpegData(compressionQuality: 0.8) {
            let newImage = ImageItem(imageData: compressedData, orderIndex: images.count)
            modelContext.insert(newImage)
            
            do {
                try modelContext.save()
                print("✅ Image saved successfully")
                return true
            } catch {
                print("❌ Failed to save image: \(error.localizedDescription)")
                return false
            }
        } else {
            print("❌ Failed to compress image to JPEG")
            return false
        }
    }
    
    private func deleteImage(_ image: ImageItem) {
        modelContext.delete(image)
        reorderImages()
    }
    
    private func moveImage(_ image: ImageItem, direction: Int) {
        guard let currentIndex = images.firstIndex(where: { $0.id == image.id }) else { return }
        let newIndex = currentIndex + direction
        
        guard newIndex >= 0 && newIndex < images.count else { return }
        
        // Swap order indices
        let temp = images[currentIndex].orderIndex
        images[currentIndex].orderIndex = images[newIndex].orderIndex
        images[newIndex].orderIndex = temp
        
        try? modelContext.save()
    }
    
    private func reorderImages() {
        for (index, image) in images.enumerated() {
            image.orderIndex = index
        }
        try? modelContext.save()
    }
}

struct ImageCard: View {
    let image: UIImage
    let index: Int
    let totalImages: Int
    let onDelete: () -> Void
    let moveUp: () -> Void
    let moveDown: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .clipped()
                .cornerRadius(12)
            
            HStack {
                Text("Image \(index + 1)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                // Move up button
                Button {
                    moveUp()
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.title3)
                }
                .disabled(index == 0)
                .opacity(index == 0 ? 0.3 : 1.0)
                
                // Move down button
                Button {
                    moveDown()
                } label: {
                    Image(systemName: "arrow.down.circle.fill")
                        .font(.title3)
                }
                .disabled(index == totalImages - 1)
                .opacity(index == totalImages - 1 ? 0.3 : 1.0)
                
                // Delete button
                Button(role: .destructive) {
                    onDelete()
                } label: {
                    Image(systemName: "trash.circle.fill")
                        .font(.title3)
                }
            }
            .padding(.horizontal, 8)
        }
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.regularMaterial)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        }
    }
}

#Preview {
    ImageSettingsView()
        .modelContainer(for: ImageItem.self, inMemory: true)
}
