# Quick Debug: Add This to See What's Happening

If images aren't showing, temporarily add this debug overlay to WaitingScreenView:

## Add Debug Overlay

In `WaitingScreenView.swift`, add this AFTER the settings buttons (before the closing `}` of the main ZStack):

```swift
// DEBUG: Temporary - Remove after testing
VStack {
    HStack {
        VStack(alignment: .leading, spacing: 4) {
            Text("🔍 DEBUG INFO")
                .font(.headline)
                .foregroundStyle(.yellow)
            Text("User Images: \(userImages.count)")
                .font(.caption)
                .foregroundStyle(.white)
            Text("All Images: \(allImages.count)")
                .font(.caption)
                .foregroundStyle(.white)
            Text("Current Index: \(currentImageIndex)")
                .font(.caption)
                .foregroundStyle(.white)
            Text("Asset Images: \(config.slideshowImages.count)")
                .font(.caption)
                .foregroundStyle(.white)
        }
        .padding(12)
        .background(.black.opacity(0.8))
        .cornerRadius(12)
        .padding(.leading, 12)
        .padding(.top, 12)
        Spacer()
    }
    Spacer()
}
```

## What You Should See

### If Images Are Loading Correctly:
```
🔍 DEBUG INFO
User Images: 5
All Images: 5
Current Index: 0 (cycles 0→1→2→3→4→0...)
Asset Images: 3
```

### If Images Aren't Persisting:
```
🔍 DEBUG INFO
User Images: 0
All Images: 3
Current Index: 0
Asset Images: 3
```
**Fix:** SwiftData not configured - check `.modelContainer` in ConConnectApp.swift

### If No Images At All:
```
🔍 DEBUG INFO
User Images: 0
All Images: 0
Current Index: 0
Asset Images: 0
```
**Fix:** Add images via photo picker OR add asset images to AppConfiguration

## Quick Tests

### Test 1: Check SwiftData Query
After adding images to Image Settings, the debug should show:
- `User Images: 5` (or however many you added)

**If it shows 0:** SwiftData isn't persisting

### Test 2: Check Image Priority
If you have user images AND asset images:
- Should use user images (All Images = User Images count)
- Should NOT fall back to assets

**If using assets despite having user images:** Priority logic broken

### Test 3: Check Index
Current Index should:
- Start at 0
- Increment every 5 seconds (or your slide interval)
- Loop back to 0 after last image

**If stuck at 0:** Timer not working

## Remove Debug Overlay

After you've identified the issue, **remove the debug code** to clean up the UI.

---

## Common Scenarios

### Scenario 1: "User Images: 0" but you added images

**Problem:** SwiftData not saving

**Check:**
1. Open ImageSettingsView - do you see images there?
2. If YES → Close and wait 2 seconds
3. Check debug again
4. If still 0 → SwiftData not configured

**Fix:**
Add to ConConnectApp.swift:
```swift
.modelContainer(for: ImageItem.self)
```

### Scenario 2: "User Images: 5" but shows placeholder

**Problem:** allImages computed property

**Check:**
The `allImages` array should have 5 items if userImages has 5.

**Fix:**
Restart app completely (force close and reopen).

### Scenario 3: Index stuck at 0

**Problem:** Timer not firing or count is wrong

**Check:**
- Are there actually images? (All Images > 0)
- Is slide interval very long? (check Settings)

**Fix:**
Set slide interval to 3 seconds for testing.

---

## Still Stuck?

If debug shows weird numbers or doesn't make sense:

1. **Clean Build:** ⌘⇧K
2. **Delete App:** From iPad
3. **Rebuild:** ⌘R
4. **Add 1 Image:** Just one for testing
5. **Check Debug:** Should show User Images: 1

If this doesn't work, there's a deeper configuration issue.
