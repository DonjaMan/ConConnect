//
//  WaitingScreenView.swift
//  ConConnect
//
//  Created by Donald Johnson on 4/29/26.
//

import Combine
import SwiftUI
import SwiftData

struct WaitingScreenView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ImageItem.orderIndex) private var userImages: [ImageItem]
    
    @State private var currentImageIndex = 0
    @State private var showingSignUpForm = false
    @State private var showingSettings = false
    @State private var showingImageSettings = false
    @State private var opacity: Double = 1.0
    @State private var secretTapCount = 0
    
    // Persistent settings using AppStorage
    @AppStorage(AppStorageKeys.slideInterval) private var slideInterval = AppConfiguration.defaultSlideInterval
    @AppStorage(AppStorageKeys.signUpFormURL) private var signUpFormURL = AppConfiguration.defaultSignUpFormURL
    @AppStorage(AppStorageKeys.companyName) private var companyName = AppConfiguration.defaultCompanyName
    @AppStorage(AppStorageKeys.companySubtitle) private var companySubtitle = AppConfiguration.defaultCompanySubtitle
    @AppStorage(AppStorageKeys.companyNameSize) private var companyNameSize = AppConfiguration.defaultCompanyNameSize
    @AppStorage(AppStorageKeys.subtitleSize) private var subtitleSize = AppConfiguration.defaultSubtitleSize
    @AppStorage(AppStorageKeys.glassFrameEnabled) private var glassFrameEnabled = AppConfiguration.defaultGlassFrameEnabled
    @AppStorage(AppStorageKeys.bannerSize) private var bannerSize = AppConfiguration.defaultBannerSize
    
    private let config = AppConfiguration.self
    
    // Get all images (user images + fallback to asset images if no user images)
    private var allImages: [ImageSource] {
        if !userImages.isEmpty {
            return userImages.map { .data($0.imageData) }
        } else if !config.slideshowImages.isEmpty {
            return config.slideshowImages.map { .asset($0) }
        } else {
            return []
        }
    }
    
    var body: some View {
        ZStack {
            // Slideshow background
            if !allImages.isEmpty {
                GeometryReader { geometry in
                    ZStack {
                        ForEach(allImages.indices, id: \.self) { index in
                            ImageSourceView(source: allImages[index])
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                                .opacity(currentImageIndex == index ? 1 : 0)
                                .animation(.easeInOut(duration: 1.0), value: currentImageIndex)
                        }
                    }
                }
                .ignoresSafeArea()
                .onReceive(Timer.publish(every: slideInterval, on: .main, in: .common).autoconnect()) { _ in
                    currentImageIndex = (currentImageIndex + 1) % allImages.count
                }
            } else {
                // Fallback if no images are configured
                placeholderView
            }
            
            // Gradient overlay for better button visibility
            VStack {
                Spacer()
                LinearGradient(
                    colors: [.clear, .black.opacity(0.6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 200)
                .allowsHitTesting(false)
            }
            .ignoresSafeArea()
            
            // Company banner - Top center third
            VStack {
                GeometryReader { geometry in
                    HStack {
                        Spacer()
                        VStack(spacing: 8) {
                            Text(companyName)
                                .font(.system(size: companyNameSize, weight: .bold))
                                .foregroundStyle(.white)
                                .shadow(color: .black.opacity(0.5), radius: 8, x: 0, y: 4)
                                .lineLimit(2)
                                .minimumScaleFactor(0.5)
                            
                            Text(companySubtitle)
                                .font(.system(size: subtitleSize, weight: .medium))
                                .foregroundStyle(.white.opacity(0.9))
                                .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 3)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                        }
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: geometry.size.width * bannerSize)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 20)
                        .background {
                            if glassFrameEnabled {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(.ultraThinMaterial)
                                    .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 8)
                            }
                        }
                        Spacer()
                    }
                    .frame(height: geometry.size.height / 3, alignment: .top)
                    .padding(.top, 50)
                }
                
                Spacer()
            }
            .allowsHitTesting(false)
            
            // Sign Up button overlay - Optimized for iPad Landscape
            VStack {
                Spacer()
                
                Button {
                    showingSignUpForm = true
                } label: {
                    HStack(spacing: 16) {
                        Image(systemName: "envelope.fill")
                            .font(.system(size: 28))
                        Text(config.signUpButtonText)
                            .font(.system(size: 32, weight: .bold))
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 60)
                    .padding(.vertical, 28)
                    .background {
                        Capsule()
                            .fill(.blue.gradient)
                            .shadow(color: .black.opacity(0.4), radius: 15, x: 0, y: 8)
                    }
                }
                .scaleEffect(opacity)
                .animation(
                    .easeInOut(duration: 1.5)
                    .repeatForever(autoreverses: true),
                    value: opacity
                )
                .onAppear {
                    opacity = 0.85
                }
                .padding(.bottom, 100)
            }
            
            // Settings button in bottom trailing corner
            VStack {
                Spacer()
                HStack {
                    // Image Settings button in bottom leading corner with app name
                    HStack(spacing: 8) {
                        Button {
                            showingImageSettings = true
                        } label: {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.system(size: 24))
                                .foregroundStyle(.white.opacity(0.7))
                                .padding(16)
                                .background {
                                    Circle()
                                        .fill(.black.opacity(0.3))
                                        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                                }
                        }
                        
                        Text("Images")
                            .font(.system(size: 14))
                            .foregroundStyle(.white.opacity(0.6))
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                    }
                    .padding(.leading, 30)
                    .padding(.bottom, 30)
                    
                    Spacer()
                    
                    // App Settings button in bottom trailing corner
                    HStack {
                        Text("Settings")
                            .font(.system(size: 14))
                            .foregroundStyle(.white.opacity(0.6))
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                        Button {
                            showingSettings = true
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 24))
                                .foregroundStyle(.white.opacity(0.7))
                                .padding(16)
                                .background {
                                    Circle()
                                        .fill(.black.opacity(0.3))
                                        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                                }
                        }
                    }
                    .padding(.trailing, 30)
                    .padding(.bottom, 30)
                }
            }
        }
        .persistentSystemOverlays(.hidden)
        .statusBarHidden()
        .sheet(isPresented: $showingSignUpForm) {
            WebFormView(url: signUpFormURL)
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
        .sheet(isPresented: $showingImageSettings) {
            ImageSettingsView()
        }
    }
    
    private var placeholderView: some View {
        Color.black
            .ignoresSafeArea()
            .overlay {
                VStack(spacing: 30) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.system(size: 100))
                        .foregroundStyle(.white.opacity(0.3))
                    
                    VStack(spacing: 10) {
                        Text("No Slideshow Images")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white.opacity(0.7))
                        
                        Text("Add images to Assets.xcassets and configure them in AppConfiguration.swift, or tap the photo icon to add images from your library")
                            .font(.body)
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                }
            }
    }
}

// MARK: - Image Source Handling

enum ImageSource {
    case asset(String)
    case data(Data)
}

struct ImageSourceView: View {
    let source: ImageSource
    
    var body: some View {
        Group {
            switch source {
            case .asset(let name):
                Image(name)
                    .resizable()
                    .scaledToFill()
            case .data(let imageData):
                if let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                } else {
                    Color.gray
                }
            }
        }
    }
}

#Preview {
    WaitingScreenView()
        .modelContainer(for: ImageItem.self, inMemory: true)
}
