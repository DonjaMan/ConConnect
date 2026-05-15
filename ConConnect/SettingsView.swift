//
//  SettingsView.swift
//  ConConnect
//
//  Created by Donald Johnson on 4/29/26.
//

import SwiftUI

/// Optional settings screen for configuring the app
/// Uses AppStorage to persist settings across app launches
struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    // Persistent settings using AppStorage
    @AppStorage(AppStorageKeys.signUpFormURL) private var formURL = AppConfiguration.defaultSignUpFormURL
    @AppStorage(AppStorageKeys.slideInterval) private var slideInterval = AppConfiguration.defaultSlideInterval
    @AppStorage(AppStorageKeys.companyName) private var companyName = AppConfiguration.defaultCompanyName
    @AppStorage(AppStorageKeys.companySubtitle) private var companySubtitle = AppConfiguration.defaultCompanySubtitle
    @AppStorage(AppStorageKeys.companyNameSize) private var companyNameSize = AppConfiguration.defaultCompanyNameSize
    @AppStorage(AppStorageKeys.subtitleSize) private var subtitleSize = AppConfiguration.defaultSubtitleSize
    @AppStorage(AppStorageKeys.glassFrameEnabled) private var glassFrameEnabled = AppConfiguration.defaultGlassFrameEnabled
    @AppStorage(AppStorageKeys.frostedFrameEnabled) private var frostedFrameEnabled = AppConfiguration.defaultFrostedFrameEnabled
    @AppStorage(AppStorageKeys.bannerSize) private var bannerSize = AppConfiguration.defaultBannerSize
    @AppStorage(AppStorageKeys.titleFont) private var titleFont = AppConfiguration.defaultTitleFont
    @AppStorage(AppStorageKeys.subtitleFont) private var subtitleFont = AppConfiguration.defaultSubtitleFont
    @AppStorage(AppStorageKeys.signUpButtonColor) private var signUpButtonColor = AppConfiguration.signUpButtonColor
    
    @State private var showingSaveConfirmation = false
    var savedColor: Color {
        Color(hex: signUpButtonColor) ?? .accentColor
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(spacing: 12) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                            .font(.title2)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Auto-Save Enabled")
                                .font(.headline)
                            Text("All changes are saved automatically")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Google Form URL")
                            .font(.headline)
                        TextField("https://docs.google.com/forms/...", text: $formURL)
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.none)
                            .keyboardType(.URL)
                    }
                } header: {
                    Text("Sign-Up Form")
                } footer: {
                    Text("Enter the complete URL to your Google Form or signup webpage. Changes are saved automatically.")
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Company Name")
                            .font(.headline)
                        TextField("Your Company Name", text: $companyName)
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.words)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Subtitle")
                            .font(.headline)
                        TextField("Artist • Creator • Innovator", text: $companySubtitle)
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.words)
                    }
                    
                    FontPickerRow(label: "Title Font", selection: $titleFont)

                    FontPickerRow(label: "Subtitle Font", selection: $subtitleFont)

                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Company Name Size")
                            Spacer()
                            Text("\(Int(companyNameSize))pt")
                                .foregroundStyle(.secondary)
                        }
                        Slider(value: $companyNameSize, in: 24...72, step: 2) {
                            Text("Company Name Size")
                        }
                    }
                    .font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Subtitle Size")
                            Spacer()
                            Text("\(Int(subtitleSize))pt")
                                .foregroundStyle(.secondary)
                        }
                        Slider(value: $subtitleSize, in: 12...48, step: 2) {
                            Text("Subtitle Size")
                        }
                    }
                    .font(.headline)
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Banner Size")
                            Spacer()
                            Text("\(Int(bannerSize * 100))%")
                                .foregroundStyle(.secondary)
                        }
                        Slider(value: $bannerSize, in: 0.2...0.8, step: 0.05) {
                            Text("Banner Size")
                        }
                    }
                    .font(.headline)
                    Toggle(isOn: $glassFrameEnabled) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Glass Frame Background")
                                .font(.headline)
                            Text("Adds a frosted glass background behind the banner")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    Toggle(isOn: $frostedFrameEnabled) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Frosted Frame Background")
                                .font(.headline)
                            Text("Adds a frosted glass background behind the banner")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                } header: {
                    Text("Company Banner")
                } footer: {
                    Text("Customize the appearance of your company banner at the top of the slideshow. Changes are saved automatically.")
                }
                
                Section {
                    HStack {
                        Text("Slide Duration")
                        Spacer()
                        Text("\(Int(slideInterval))s")
                            .foregroundStyle(.secondary)
                    }
                    
                    Slider(value: $slideInterval, in: 3...15, step: 1) {
                        Text("Slide Duration")
                    }
                } header: {
                    Text("Slideshow Settings")
                } footer: {
                    Text("Time each image displays before transitioning to the next (3-15 seconds). Changes are saved automatically.")
                }
                Section {
                    ColorPicker(selection: Binding(
                        get: { savedColor },
                        set: { newColor in signUpButtonColor = newColor.toHex() }
                    )) {
                       Text("SignUp Button Color")
                    }
                } header: {
                    Text("SignUp Button Color")
                }
                Section {
                    Button {
                        testForm()
                    } label: {
                        HStack {
                            Image(systemName: "link.circle")
                            Text("Test Form URL")
                        }
                    }
                } footer: {
                    Text("Opens the form to verify it loads correctly.")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .alert("Settings Saved", isPresented: $showingSaveConfirmation) {
                Button("OK", role: .cancel) {
                    dismiss()
                }
            } message: {
                Text("Your settings have been saved and will persist across app launches.")
            }
        }
    }
    
    private func testForm() {
        if let url = URL(string: formURL) {
            UIApplication.shared.open(url)
        }
    }
}

struct FontPickerRow: View {
    let label: String
    @Binding var selection: String

    private var displayName: String {
        for group in AppConfiguration.availableFonts {
            for font in group.fonts {
                if font.postScript == selection {
                    return font.name
                }
            }
        }
        return selection
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.headline)
            Picker(label, selection: $selection) {
                ForEach(AppConfiguration.availableFonts, id: \.family) { group in
                    Section(group.family) {
                        ForEach(group.fonts, id: \.postScript) { font in
                            Text(font.name)
                                .font(.custom(font.postScript, size: 17))
                                .tag(font.postScript)
                        }
                    }
                }
            }
            .pickerStyle(.menu)
            .frame(maxWidth: .infinity, alignment: .leading)

            Text("Preview")
                .font(.custom(selection, size: 22))
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    SettingsView()
}
