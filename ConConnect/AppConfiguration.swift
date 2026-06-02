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
    static let defaultSignUpFormURL = "http://donjamedia.com/ConnConnect_SampleSignIn.html"
    
    /// Default company name for banner
    static let defaultCompanyName = "Your Company Name"
    
    /// Default subtitle for banner
    static let defaultCompanySubtitle = "Artist • Creator • Innovator"
    
    /// Default company name font size
    static let defaultCompanyNameSize: Double = 48.0
    
    /// Default subtitle font size
    static let defaultSubtitleSize: Double = 24.0
    
    static let bannerBackgroundStyle: BannerBackgroundStyle = .frosted

    /// Default banner size as a fraction of screen width (0.2 to 0.8)
    static let defaultBannerSize: Double = 0.33

    /// Default fonts for banner text
    static let defaultTitleFont = "Montserrat-BoldItalic"
    static let defaultSubtitleFont = "Montserrat-Regular"

    /// Available custom fonts grouped by family
    static let availableFonts: [(family: String, fonts: [(name: String, postScript: String)])] = [
        ("Bebas Neue", [
            ("Bebas Neue", "BebasNeue-Regular"),
        ]),
        ("Coiny", [
           ("Coiny", "Coiny-Regular"),
        ]),
        ("Dancing Script", [
            ("Dancing Script", "DancingScript-Regular"),
            ("Dancing Script Bold", "DancingScript-Bold"),
        ]),
        ("Great Vibes", [
            ("Great Vibes", "GreatVibes-Regular"),
        ]),
        ("ImperialScript", [
            ("ImperialScript", "ImperialScript-Regular"),
        ]),
        ("LimeLight", [
           ("LimeLight", "LimeLight-Regular"),
        ]),
        ("Lobster", [
           ("Lobster", "Lobster-Regular")
        ]),
        ("Montserrat", [
            ("Montserrat Thin", "Montserrat-Thin"),
            ("Montserrat Thin Italic", "Montserrat-ThinItalic"),
            ("Montserrat", "Montserrat-Regular"),
            ("Montserrat Italic", "Montserrat-Italic"),
            ("Montserrat Bold", "Montserrat-Bold"),
            ("Montserrat Bold Italic", "Montserrat-BoldItalic"),
        ]),
        ("Orbitron", [
           ("Orbitron", "Orbitron-Regular"),
           ("Orbitron SemiBold", "Orbitron-SemiBold"),
           ("Orbitron Bold", "Orbitron-Bold"),
        ]),
        ("Oswald", [
            ("Oswald", "Oswald-Regular"),
            ("Oswald Medium", "Oswald-Medium"),
            ("Oswald Bold", "Oswald-Bold"),
        ]),
        ("Satisfy", [
            ("Satisfy", "Satisfy-Regular"),
        ]),
        ("StoryScript", [
            ("StoryScript", "StoryScript-Regular"),
        ]),

    ]

    // MARK: - UI Configuration
    
    /// Sign-up button text (optimized for iPad landscape viewing)
    static let signUpButtonText = "Sign Up for Mailing List"
    
    /// Enable SignUP Button ColorBeam Effect
    static let signUpButtonColorBeamEnabled: Bool = false
    
    /// Show Logo
    static let showLogo: Bool = false
    
    /// Logo Image URL
    static let logoImageURL: String? = nil
    
    /// Sign-up button Color
    static let signUpButtonColor = "#FFFFFF"
    
    /// Signup Button Background Style
    static let signupButtonBackgroundStyle: SignUpButtonStyle = .solid
    
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
    static let bannerBackgroundStyle = "bannerBackgroundStyle"
    static let bannerSize = "bannerSize"
    static let titleFont = "titleFont"
    static let subtitleFont = "subtitleFont"
    static let signUpButtonColor = "signUpButtonColor"
    static let signUpButtonColorBeamEnabled = "signUpButtonColorBeamEnabled"
    static let signupButtonBackgroundStyle = "signupButtonBackgroundStyle"
    static let showLogo = "showLogo"
    static let logoImageURL = "logoImageURL"
}

/// Enum for Signup Button Backround style
enum SignUpButtonStyle: String, Codable, CaseIterable {
    case glass
    case solid
    case frosted
    
}

/// Enum for Banner Background style
enum BannerBackgroundStyle: String, Codable, CaseIterable {
    case glass
    case frosted
    case solid
}

