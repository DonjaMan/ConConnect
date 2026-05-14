# 🚀 ConConnect - iPad Landscape Quick Start

## ⚡️ 3-Minute Setup

### 1. Configure Info.plist (REQUIRED)

**In Xcode:**
- Select Project → Target "ConConnect" → General tab
- **Supported Destinations:** iPad only (uncheck iPhone)
- **Device Orientation:** Landscape Left + Landscape Right only

**OR manually add to Info.plist:**
```xml
<key>UIDeviceFamily</key>
<array><integer>2</integer></array>

<key>UISupportedInterfaceOrientations~ipad</key>
<array>
    <string>UIInterfaceOrientationLandscapeLeft</string>
    <string>UIInterfaceOrientationLandscapeRight</string>
</array>

<key>UIRequiresFullScreen</key>
<true/>

<key>UIStatusBarHidden</key>
<true/>
```

### 2. Add Images
- Open **Assets.xcassets**
- Drag landscape-oriented images
- Name: slide1, slide2, slide3...

### 3. Configure
**AppConfiguration.swift:**
```swift
static let slideshowImages = ["slide1", "slide2", "slide3"]
static let signUpFormURL = "YOUR_GOOGLE_FORM_URL"
```

### 4. Build
- Select iPad device
- Press **⌘R**
- Done! ✅

---

## ✅ What You Have

- ✅ **iPad-only app** (won't run on iPhone)
- ✅ **Landscape locked** (no portrait rotation)
- ✅ **Large 32pt button** (optimized for iPad)
- ✅ **Full-screen mode** (no status bar)
- ✅ **Combine import** (compiler error fixed)
- ✅ **Convention-ready** (professional kiosk mode)

---

## 🎯 At Your Convention

1. Launch app → auto-rotates to landscape
2. Enable Guided Access (triple-click side button)
3. Place on table stand
4. Visitors tap button → sign up → return to slideshow
5. App stays landscape throughout!

---

## 📱 iPad Recommendations

- **Best:** iPad Pro 12.9" (maximum impact)
- **Great:** iPad Pro 11" or iPad Air
- **Good:** iPad 10th gen or newer

**All in landscape mode for wide viewing!**

---

## 🔧 Quick Fixes

| Issue | Solution |
|-------|----------|
| Still rotates? | Check Info.plist orientation settings |
| Build error? | Already fixed - Combine imported |
| Button small? | Already optimized - 32pt font, 60px padding |
| Images wrong? | Use landscape-oriented images |

---

## 📖 Full Documentation

- **IPAD_LANDSCAPE_COMPLETE.md** - Complete setup guide
- **IPAD_LANDSCAPE_SETUP.md** - Detailed configuration
- **README.md** - Feature documentation
- **BUILD_INSTRUCTIONS.md** - Build process

---

**You're ready to build! Press ⌘R** 🚀
