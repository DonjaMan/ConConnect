# AppStorage Persistence Guide

## ✅ Persistent Settings Implemented

Your ConConnect app now uses **AppStorage** to persist settings across app launches. Changes made in the Settings panel are automatically saved and will be remembered even after closing the app or restarting the device.

## 🔄 What's Persisted

### Settings That Are Saved:

1. **Slide Interval** (3-15 seconds)
   - How long each image displays before transitioning
   - Default: 5 seconds
   - Adjustable via slider in Settings

2. **Sign-Up Form URL**
   - Your Google Form or signup webpage URL
   - Default: Set in AppConfiguration.swift
   - Editable via text field in Settings

## 📝 How It Works

### AppStorage Overview

AppStorage is a SwiftUI property wrapper that:
- ✅ Automatically saves values to UserDefaults
- ✅ Persists across app launches
- ✅ Updates all views when values change
- ✅ Is simple and declarative
- ✅ Works seamlessly with SwiftUI

### Implementation Details

**AppConfiguration.swift:**
```swift
// Default values (used on first launch)
static let defaultSlideInterval: TimeInterval = 5.0
static let defaultSignUpFormURL = "https://docs.google.com/..."

// Storage keys
enum AppStorageKeys {
    static let slideInterval = "slideInterval"
    static let signUpFormURL = "signUpFormURL"
}
```

**WaitingScreenView.swift:**
```swift
// Persistent settings using AppStorage
@AppStorage(AppStorageKeys.slideInterval) 
private var slideInterval = AppConfiguration.defaultSlideInterval

@AppStorage(AppStorageKeys.signUpFormURL) 
private var signUpFormURL = AppConfiguration.defaultSignUpFormURL
```

**SettingsView.swift:**
```swift
// Same AppStorage properties - automatically synced!
@AppStorage(AppStorageKeys.signUpFormURL) 
private var formURL = AppConfiguration.defaultSignUpFormURL

@AppStorage(AppStorageKeys.slideInterval) 
private var slideInterval = AppConfiguration.defaultSlideInterval
```

## 🎯 User Experience

### First Launch:
1. App uses default values from AppConfiguration.swift
2. Slideshow runs at 5-second intervals
3. Sign-up button uses default URL (placeholder)

### Configuring Settings:
1. Tap gear icon (⚙️) in bottom-right corner
2. Edit form URL and/or slide interval
3. Changes are **automatically saved** as you type/adjust
4. Tap "Done" to close settings

### Subsequent Launches:
1. App remembers your settings
2. Slideshow uses your custom interval
3. Sign-up button uses your custom URL
4. Settings persist across app restarts, device reboots, etc.

## ✨ Benefits

### For App Owners:

✅ **No Manual Saving** - Changes save automatically  
✅ **Persistent** - Settings remembered across launches  
✅ **Convention-Friendly** - Set once, use at multiple events  
✅ **Quick Updates** - Change form URL between conventions  
✅ **Flexible Timing** - Adjust slide speed for different artwork  

### Technical Benefits:

✅ **Native iOS** - Uses built-in UserDefaults  
✅ **Type-Safe** - Compile-time checking  
✅ **SwiftUI Integration** - Automatic UI updates  
✅ **Low Overhead** - Minimal performance impact  
✅ **Reliable** - Backed by Apple's UserDefaults system  

## 📊 Settings Behavior

### Slide Interval:

| Setting | Behavior |
|---------|----------|
| **Range** | 3-15 seconds |
| **Step** | 1 second increments |
| **Default** | 5 seconds |
| **Persistence** | Saved immediately when slider moves |
| **Effect** | Timer updates on next cycle |

### Form URL:

| Setting | Behavior |
|---------|----------|
| **Type** | Text string (URL) |
| **Default** | Placeholder from AppConfiguration |
| **Persistence** | Saved as you type |
| **Validation** | None (any string accepted) |
| **Effect** | Used when sign-up button tapped |

## 🔧 Advanced Usage

### Reset to Defaults

To reset settings to defaults, you can:

**Option 1: Delete App**
- Delete and reinstall the app
- All UserDefaults are cleared

**Option 2: Manual Reset in Settings**
Add a reset button to SettingsView.swift:

```swift
Button("Reset to Defaults", role: .destructive) {
    slideInterval = AppConfiguration.defaultSlideInterval
    formURL = AppConfiguration.defaultSignUpFormURL
}
```

**Option 3: Code-Based Reset**
In your app code:
```swift
UserDefaults.standard.removeObject(forKey: AppStorageKeys.slideInterval)
UserDefaults.standard.removeObject(forKey: AppStorageKeys.signUpFormURL)
```

### Accessing Stored Values Outside SwiftUI

If you need to access these values in non-SwiftUI code:

```swift
// Read values
let interval = UserDefaults.standard.double(forKey: AppStorageKeys.slideInterval)
let url = UserDefaults.standard.string(forKey: AppStorageKeys.signUpFormURL)

// Write values
UserDefaults.standard.set(7.0, forKey: AppStorageKeys.slideInterval)
UserDefaults.standard.set("https://...", forKey: AppStorageKeys.signUpFormURL)
```

### Syncing Across Devices (Optional)

To sync settings via iCloud, change UserDefaults to NSUbiquitousKeyValueStore:

```swift
// NOT IMPLEMENTED - Would require:
// 1. Enable iCloud capability in Xcode
// 2. Replace UserDefaults with NSUbiquitousKeyValueStore
// 3. Handle iCloud sync notifications
```

## 🎪 Convention Workflow

### Before First Convention:

1. Open app on your iPad
2. Tap gear icon (⚙️)
3. Enter your Google Form URL
4. Adjust slide interval if desired
5. Tap "Done"
6. Settings are now saved!

### At Convention:

- App uses your saved settings
- No need to reconfigure
- Settings persist even if app crashes or device restarts

### Between Conventions:

- Update form URL for different events
- Adjust timing based on feedback
- Test changes before next event
- Settings automatically saved

### After Convention:

- Settings remain saved
- Ready for next event
- Can update anytime

## 💡 Best Practices

### Slide Interval:

- **5 seconds** (default) - Good balance for most artwork
- **3-4 seconds** - Fast-paced, attention-grabbing
- **7-10 seconds** - Detailed artwork that needs viewing time
- **12-15 seconds** - Complex pieces or photography

### Form URL:

- Use **short URLs** if possible (Google Form URLs can be long)
- Test the URL in Settings before convention
- Consider creating **different forms** for different events
- Update between conventions to track which event leads came from

### General:

- ✅ Test settings changes before each convention
- ✅ Keep default values reasonable in AppConfiguration.swift
- ✅ Don't rely on settings alone - have backup plan
- ✅ Document your preferred settings for reference

## 🐛 Troubleshooting

### Settings not saving?

**Check:**
- AppStorage property wrappers are correctly defined
- Keys in AppStorageKeys match between files
- You're not force-quitting app before saving
- Device has storage space available

**Fix:**
- Settings save automatically - no "Save" button needed
- Just close Settings view and values are persisted

### Settings reset to defaults?

**Possible causes:**
- App was deleted and reinstalled
- UserDefaults was cleared by system (rare)
- iOS storage cleanup (very rare)

**Prevention:**
- Keep backups of your URLs in Notes app
- Document settings in AppConfiguration.swift comments

### Timer not updating with new interval?

**Explanation:**
- Timer updates on next cycle, not immediately
- New interval takes effect after current cycle completes

**Workaround:**
- Close and reopen app to see immediate effect
- Or wait for current cycle to complete

## 📱 Data Storage Location

Your settings are stored in:
```
/var/mobile/Containers/Data/Application/[APP_ID]/Library/Preferences/
com.yourcompany.ConConnect.plist
```

This is managed automatically by iOS and persists through:
- ✅ App updates
- ✅ Device restarts
- ✅ iOS updates
- ✅ App backgrounding

Only cleared when:
- ❌ App is deleted
- ❌ "Reset All Settings" in iOS Settings
- ❌ Device is erased

## 🎊 Summary

Your app now has:
- ✅ **Automatic settings persistence** via AppStorage
- ✅ **No "Save" button needed** - changes saved instantly
- ✅ **Synchronized across views** - WaitingScreen and Settings stay in sync
- ✅ **Convention-ready** - Configure once, use everywhere
- ✅ **Reliable storage** - Built on iOS UserDefaults

**Settings will now persist across app launches, device restarts, and iOS updates!** 🎉
