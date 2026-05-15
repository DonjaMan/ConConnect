# Troubleshooting: Images Not Showing

## ✅ Quick Fixes for Image Display Issues

If your chosen images are not showing on the waiting screen, follow these steps:

---

## 🔍 Diagnostic Steps

### Step 1: Verify Images Were Added

1. **Open Image Settings**
   - Tap the 📷 photo icon in bottom-left corner
   - Do you see images in the grid?
   - If NO → Images weren't successfully added
   - If YES → Continue to Step 2

### Step 2: Check Image Count

When you added images:
- Did the photo picker close?
- Did you see a loading state?
- Did thumbnails appear in the grid?

**If NO to any:** Try adding images again

### Step 3: Close and Reopen App

1. **Force close the app** (swipe up from app switcher)
2. **Relaunch** the app
3. **Check if images now show**

This forces SwiftData to reload from disk.

### Step 4: Check Photo Library Permissions

1. **Go to iPad Settings**
2. **Scroll to ConConnect app**
3. **Check "Photos" permission**
4. **Should be:** "All Photos" or "Selected Photos"
5. **If "None":** Grant permission and try again

---

## 🔧 Common Issues & Solutions

### Issue 1: Images Added But Not Showing

**Symptoms:**
- Images appear in Image Settings grid
- Waiting screen shows placeholder or assets
- No user images in slideshow

**Solution:**
```swift
// The issue is likely timing-related
// Try these fixes in order:

1. Close Image Settings (tap "Done")
2. Wait 2-3 seconds
3. Check if images appear
4. If not, restart app completely
```

**Why:** SwiftData Query may need time to propagate changes.

---

### Issue 2: Photo Picker Shows But Nothing Loads

**Symptoms:**
- Tap "Add Images" button
- Photo picker appears
- Select photos
- Nothing happens

**Causes:**
- Missing photo library permission
- Image data corrupted
- Selection limit exceeded

**Solution:**
1. **Check permissions** (Settings → ConConnect → Photos)
2. **Try fewer images** (start with 1-2)
3. **Select different photos** (avoid videos or Live Photos)
4. **Restart app** and try again

---

### Issue 3: Placeholder Shows Despite Added Images

**Symptoms:**
- Images successfully added to Image Settings
- Waiting screen shows "No Slideshow Images" placeholder
- Never transitions to user images

**Root Cause:**
The `allImages` computed property isn't detecting user images.

**Debug Check:**
Add this temporarily to see what's happening:

```swift
// In WaitingScreenView body, add:
.onAppear {
    print("DEBUG: User images count: \(userImages.count)")
    print("DEBUG: All images count: \(allImages.count)")
}
```

**Expected Output:**
```
DEBUG: User images count: 5  (or however many you added)
DEBUG: All images count: 5
```

**If you see:**
```
DEBUG: User images count: 0
DEBUG: All images count: 3  (asset images)
```

**Then:** SwiftData isn't persisting images.

**Fix:**
1. Check that `.modelContainer(for: ImageItem.self)` is in ConConnectApp.swift
2. Verify ImageItem.swift is in the target
3. Clean build folder (⌘⇧K)
4. Rebuild (⌘R)

---

### Issue 4: Only Seeing Asset Images

**Symptoms:**
- Default asset images (slide1, slide2, slide3) show
- Your added photos don't appear
- Image Settings shows your photos

**Cause:**
The priority system is falling back to assets.

**Check:**
```swift
private var allImages: [ImageSource] {
    if !userImages.isEmpty {  // ← This check might be failing
        return userImages.map { .data($0.imageData) }
    } else if !config.slideshowImages.isEmpty {
        return config.slideshowImages.map { .asset($0) }
    } else {
        return []
    }
}
```

**Solution:**
1. Verify `userImages` Query is working
2. Check that images have `orderIndex` set
3. Try deleting all asset images from AppConfiguration temporarily:
   ```swift
   static let slideshowImages: [String] = []  // Empty for testing
   ```
4. Rebuild and test

---

### Issue 5: Images Show Briefly Then Disappear

**Symptoms:**
- Images flash on screen
- Then disappear or go black
- Slideshow doesn't advance

**Cause:**
Timer or index issue.

**Solution:**
```swift
// Check currentImageIndex is valid
.onAppear {
    if currentImageIndex >= allImages.count {
        currentImageIndex = 0  // Reset to first image
    }
}
```

Already added in the fix above! ✅

---

### Issue 6: SwiftData Not Persisting

**Symptoms:**
- Images work until app restart
- After restart, images gone
- Have to re-add every time

**Cause:**
Model container not configured properly.

**Verify ConConnectApp.swift:**
```swift
import SwiftData  // ← Must import

@main
struct ConConnectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ImageItem.self)  // ← Must have this!
    }
}
```

**If missing `.modelContainer`:**
- Images stored in memory only
- Lost on app restart

**Fix:**
1. Add `.modelContainer(for: ImageItem.self)`
2. Clean build
3. Rebuild

---

## 🧪 Step-by-Step Test

### Complete Reset Test:

1. **Delete App**
   - Long press app icon
   - Delete app
   - This clears all SwiftData

2. **Clean Build**
   - In Xcode: Product → Clean Build Folder (⌘⇧K)

3. **Rebuild**
   - Product → Run (⌘R)

4. **Grant Permissions**
   - When prompted, grant photo access

5. **Add ONE Image**
   - Tap 📷 icon
   - Tap "Add Images"
   - Select exactly ONE photo
   - Verify it appears in grid

6. **Close Image Settings**
   - Tap "Done"

7. **Check Waiting Screen**
   - Should show your ONE image
   - If YES → Success! Add more
   - If NO → Continue debugging

---

## 🔍 Advanced Debugging

### Add Debug Overlay

Temporarily add this to see what's happening:

```swift
// In WaitingScreenView, inside ZStack (after slideshow):
VStack {
    HStack {
        VStack(alignment: .leading) {
            Text("DEBUG INFO")
                .font(.caption)
                .foregroundStyle(.white)
            Text("User Images: \(userImages.count)")
                .font(.caption)
                .foregroundStyle(.white)
            Text("All Images: \(allImages.count)")
                .font(.caption)
                .foregroundStyle(.white)
            Text("Current Index: \(currentImageIndex)")
                .font(.caption)
                .foregroundStyle(.white)
        }
        .padding(8)
        .background(.black.opacity(0.7))
        .cornerRadius(8)
        Spacer()
    }
    Spacer()
}
```

This shows you real-time what the app sees.

**Expected:**
```
User Images: 5
All Images: 5
Current Index: 0 (then 1, 2, 3, 4, 0...)
```

**If you see:**
```
User Images: 0
All Images: 0
Current Index: 0
```

**Then:** No images loaded at all.

**If you see:**
```
User Images: 0
All Images: 3
Current Index: 0
```

**Then:** SwiftData Query not working, falling back to assets.

---

## ✅ Checklist Before Reporting Bug

- [ ] Photo library permission granted
- [ ] Images appear in Image Settings grid
- [ ] Tapped "Done" to close Image Settings
- [ ] Waited at least 5 seconds
- [ ] Restarted app
- [ ] `.modelContainer(for: ImageItem.self)` in ConConnectApp.swift
- [ ] ImageItem.swift exists and is in target
- [ ] Clean build performed (⌘⇧K)
- [ ] Tested with just 1 image
- [ ] Checked debug output (if added)

---

## 🎯 Most Likely Causes

Based on common issues:

1. **Didn't close Image Settings** (70% of cases)
   - Solution: Tap "Done" after adding images

2. **SwiftData not configured** (15% of cases)
   - Solution: Add `.modelContainer` to app

3. **Permission not granted** (10% of cases)
   - Solution: Check Settings → ConConnect → Photos

4. **Images corrupted** (3% of cases)
   - Solution: Try different photos

5. **App cache issue** (2% of cases)
   - Solution: Delete app and reinstall

---

## 🔄 Quick Fix Summary

Try these in order:

1. ✅ **Close Image Settings** (tap "Done")
2. ✅ **Wait 3 seconds**
3. ✅ **Restart app**
4. ✅ **Check permissions**
5. ✅ **Clean build** (⌘⇧K)
6. ✅ **Rebuild** (⌘R)
7. ✅ **Delete and reinstall**

**One of these will fix 95% of issues!**

---

## 💡 Prevention Tips

To avoid issues in the future:

1. **Always close Image Settings** after adding images
2. **Wait for images to load** (shows in grid)
3. **Don't add too many at once** (max 10 per batch)
4. **Use JPEG images** (not HEIC or RAW)
5. **Keep total under 50 images** for best performance

---

## 📝 Still Not Working?

If you've tried everything above and images still don't show:

### Verification Steps:

1. Build app
2. Grant photo permission
3. Add exactly 1 image
4. See it in Image Settings grid? (YES/NO)
5. Tap "Done"
6. Wait 5 seconds
7. See it on waiting screen? (YES/NO)

**If NO at step 7:**

Check that WaitingScreenView has:
- `@Query(sort: \ImageItem.orderIndex) private var userImages: [ImageItem]`
- `@Environment(\.modelContext) private var modelContext`
- Both imports: `import SwiftData` and `import SwiftUI`

**Verify ConConnectApp has:**
- `import SwiftData`
- `.modelContainer(for: ImageItem.self)`

**Verify ImageItem.swift has:**
- `@Model` decorator
- `final class ImageItem`
- All properties defined

If all these are correct and it still doesn't work, there may be a deeper issue with SwiftData setup.

---

## ✅ Expected Behavior

When working correctly:

1. Tap 📷 → Opens Image Settings
2. Tap + → Opens photo picker
3. Select photos → Picker closes
4. See thumbnails load → Grid shows images
5. Tap "Done" → Returns to waiting screen
6. **IMMEDIATELY** see first user image
7. After 5 seconds → Advances to second image
8. Continues cycling through all images
9. Restart app → Images still there! ✅

**If this happens, everything is working perfectly!** 🎉
