# ⚡️ Quick Reference: AppStorage Settings

## 🎯 How to Configure Your App

### Step 1: Launch App
- App shows slideshow with placeholder settings

### Step 2: Open Settings
- Tap **⚙️ gear icon** in bottom-right corner

### Step 3: Configure
- **Form URL:** Enter your Google Form URL
  - Saves **as you type**
- **Slide Interval:** Adjust slider (3-15 seconds)
  - Saves **as you move**

### Step 4: Close
- Tap **"Done"**
- Settings automatically saved! ✅

### Step 5: Use
- Settings persist forever (until app deleted)
- Use at all your conventions!

---

## 📊 Settings Reference

| Setting | Default | Range | Location |
|---------|---------|-------|----------|
| **Slide Interval** | 5 sec | 3-15 sec | Settings → Slideshow Settings |
| **Form URL** | Placeholder | Any URL | Settings → Sign-Up Form |

---

## ✨ Key Features

- ✅ **Auto-Save** - No save button needed
- ✅ **Persistent** - Survives app restarts
- ✅ **Instant Sync** - All views update immediately
- ✅ **Convention-Ready** - Set once, use everywhere

---

## 🔄 How It Works

```
Edit Setting → AppStorage → UserDefaults → Persisted to Disk
                    ↓
            All Views Update Automatically
```

---

## 💡 Pro Tips

1. **Test Before Convention**
   - Change settings
   - Close app completely
   - Reopen and verify settings saved

2. **Different Events**
   - Create different Google Forms per event
   - Update URL in Settings before each convention
   - Track which event each lead came from

3. **Backup Your URL**
   - Save Google Form URL in Notes app
   - Document in AppConfiguration.swift comments
   - Keep backup in case you need to reset

---

## 🆘 Quick Troubleshooting

### Settings disappeared?
- Check if app was deleted (clears UserDefaults)
- Re-enter settings in Settings panel

### Timer not updating?
- Wait for current cycle to complete
- Or close and reopen app for immediate effect

### Form URL not working?
- Test in Settings panel (tap "Test Form URL")
- Verify URL is correct
- Check internet connection

---

**Your settings now persist automatically! Configure once and you're ready!** 🎉
