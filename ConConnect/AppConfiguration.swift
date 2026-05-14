//
//  AppConfiguration.swift
//  ConConnect
//
//  Created by Donald Johnson on 4/29/26.
//

import Foundation
import SwiftUI

/// Centralized configuration for the ConConnect app
/// Optimized for iPad in landscape orientation
/// Uses AppStorage for persistent settings
struct AppConfiguration {
    
    // MARK: - Slideshow Configuration
    
    /// Names of images in Assets.xcassets to display in the slideshow
    /// Add your artwork images to the asset catalog and list their names here
    /// RECOMMENDED: Use landscape-oriented images (wider than tall) for iPad landscape display
    static let slideshowImages = [
        "slide1",
        "slide2",
        "slide3"
    ]
    
    // MARK: - Persistent Settings (AppStorage)
    
    /// Default time interval between slides (in seconds)
    /// This value is used if no custom value has been saved
    static let defaultSlideInterval: TimeInterval = 5.0
    
    /// Default URL to your Google Docs form or signup web page
    /// This value is used if no custom URL has been saved
    /// Example: "https://docs.google.com/forms/d/e/1FAIpQLSc.../viewform"
    static let defaultSignUpFormURL = "https://docs.google.com/forms/d/e/YOUR_FORM_ID/viewform"
    
    /// Default company name for banner
    static let defaultCompanyName = "Your Company Name"
    
    /// Default subtitle for banner
    static let defaultCompanySubtitle = "Artist • Creator • Innovator"
    
    /// Default company name font size
    static let defaultCompanyNameSize: Double = 48.0
    
    /// Default subtitle font size
    static let defaultSubtitleSize: Double = 24.0
    
    /// Default glass frame enabled state
    static let defaultGlassFrameEnabled: Bool = false

    /// Default banner size as a fraction of screen width (0.2 to 0.8)
    static let defaultBannerSize: Double = 0.33
    
    // MARK: - UI Configuration
    
    /// Sign-up button text (optimized for iPad landscape viewing)
    static let signUpButtonText = "Sign Up for Mailing List"
    
    /// Navigation bar title for the web form
    static let formTitle = "Sign Up"
    
    /// Enable/disable slide transition animations
    static let animateTransitions = true
}
/// Keys for AppStorage persistence
enum AppStorageKeys {
    static let slideInterval = "slideInterval"
    static let signUpFormURL = "signUpFormURL"
    static let companyName = "companyName"
    static let companySubtitle = "companySubtitle"
    static let companyNameSize = "companyNameSize"
    static let subtitleSize = "subtitleSize"
    static let glassFrameEnabled = "glassFrameEnabled"
    static let bannerSize = "bannerSize"
}

