# ConConnect - Convention Sign-Up App

## 🎯 Quick Start Guide

### Step 1: Add Your Artwork Images

1. In Xcode, open the **Project Navigator** (left sidebar)
2. Click on **Assets.xcassets**
3. Drag and drop your artwork/portfolio images into the asset catalog
4. Name each image (e.g., "slide1", "slide2", "slide3")

### Step 2: Configure the App

Open **AppConfiguration.swift** and update:

```swift
// Add your image names
static let slideshowImages = [
    "slide1",      // Replace with your actual image names
    "slide2",
    "slide3"
]

// Set your Google Form URL
static let signUpFormURL = "https://docs.google.com/forms/d/e/YOUR_FORM_ID/viewform"
```

### Step 3: Create Your Google Form

1. Go to https://docs.google.com/forms
2. Click **+ Blank** to create a new form
3. Add fields for:
   - Name
   - Email Address
   - Phone (optional)
   - Any other information you want to collect
4. Click **Send** → **Link** icon
5. Copy the URL and paste it into `AppConfiguration.swift`

### Step 4: Build and Run

1. Connect your iPad or iPhone
2. Select your device in Xcode's toolbar
3. Press **Cmd + R** to build and run
4. The app is ready for your convention!

## ✨ Features

- ✅ **Automatic Slideshow**: Your artwork cycles every 5 seconds
- ✅ **Smooth Transitions**: Professional fade animations
- ✅ **Prominent Sign-Up Button**: Pulsing button catches attention
- ✅ **Full-Screen Mode**: Hides status bar for immersive display
- ✅ **Web Form Integration**: Uses Google Forms (no backend needed!)
- ✅ **Error Handling**: Graceful handling of network issues
- ✅ **Loading Indicators**: Shows progress while loading form

## 🎨 Customization Options

In **AppConfiguration.swift**, you can customize:

```swift
// Timing
static let slideInterval: TimeInterval = 5.0  // Change to 3.0 for faster, 10.0 for slower

// Button text
static let signUpButtonText = "Join My Mailing List"  // Customize the message

// Form title
static let formTitle = "Sign Up"  // Change the navigation bar title
```

## 📱 Convention Day Tips

1. **Test Before**: Make sure all images load and the form URL works
2. **Full Charge**: Keep your device charged or plugged in
3. **WiFi/Cellular**: Ensure good internet connection for form submissions
4. **Stand Setup**: Position device where people can easily interact
5. **Guided Lock**: Consider using Guided Access (Settings → Accessibility) to prevent users from leaving the app

## 🔒 Enable Guided Access (Optional but Recommended)

This locks the device to only your app during the convention:

1. Go to **Settings** → **Accessibility** → **Guided Access**
2. Turn on **Guided Access**
3. Set a passcode
4. Launch ConConnect
5. Triple-click the side/home button
6. Tap **Start**

Now people can't exit the app or access other parts of your device!

## 🛠 Technical Details

- **Framework**: SwiftUI + WebKit
- **iOS Version**: iOS 17.0+
- **Device**: iPad only (landscape orientation locked)
- **Orientation**: Landscape only (left or right)
- **Display Mode**: Full screen, status bar hidden
- **Network**: Required only for form submission

## 📊 Tracking Sign-Ups

Your Google Form automatically:
- Saves all responses
- Creates a spreadsheet
- Can send you email notifications
- Exports to CSV/Excel

View responses at: https://docs.google.com/forms → Your Form → Responses tab

## 🎨 Sample Image Recommendations

For best results on iPad in landscape:
- **Resolution**: 2560x1600 or higher (landscape orientation)
- **Format**: JPEG or PNG
- **Content**: Your best portfolio pieces
- **Quantity**: 5-10 images work well
- **Aspect Ratio**: 16:10 or 4:3 in landscape orientation
- **Orientation**: Horizontal/landscape crops recommended

## 🚀 Ready to Go!

Your app is now configured and ready for convention use. Good luck collecting those sign-ups!
