# 🎉 ConConnect App - READY TO BUILD!

## ✅ What's Been Built

Your convention sign-up app is now complete with all these features:

### Core Files Created:
1. **ContentView.swift** - App entry point ✅
2. **WaitingScreenView.swift** - Main slideshow screen ✅
3. **WebFormView.swift** - Web form integration ✅
4. **AppConfiguration.swift** - Easy configuration ✅
5. **SettingsView.swift** - Hidden settings panel ✅

### Documentation Created:
1. **README.md** - Complete user guide
2. **SETUP_CHECKLIST.md** - Step-by-step setup
3. **INFO_PLIST_NOTES.md** - Configuration notes
4. **BUILD_INSTRUCTIONS.md** - This file!

---

## 🚀 BUILD INSTRUCTIONS

### Step 1: Verify Files are Added to Target
1. In Xcode, select each `.swift` file in the Project Navigator
2. In the right sidebar, check that "ConConnect" is checked under "Target Membership"

### Step 2: Add Your Images (REQUIRED)
1. Click **Assets.xcassets** in the Project Navigator
2. Drag and drop 3-10 images of your artwork
3. Name them: "slide1", "slide2", "slide3", etc.

### Step 3: Configure the App
1. Open **AppConfiguration.swift**
2. Update the `slideshowImages` array with your image names:
   ```swift
   static let slideshowImages = [
       "slide1",
       "slide2", 
       "slide3"
   ]
   ```

3. Create a Google Form at https://docs.google.com/forms
4. Get the form URL
5. Update `signUpFormURL` in AppConfiguration.swift

### Step 4: Build & Run
1. Select your device or simulator from the Xcode toolbar
2. Press **⌘R** (or click the Play button)
3. Wait for the build to complete
4. The app should launch showing your slideshow!

---

## 📱 TESTING YOUR APP

### Test Checklist:
- [ ] Slideshow cycles through all images
- [ ] Images transition smoothly every 5 seconds
- [ ] "Sign Up" button is visible and pulsing
- [ ] Tapping button opens web form
- [ ] Google Form loads correctly
- [ ] Can submit form successfully
- [ ] "Done" button returns to slideshow
- [ ] Triple-tap top-left corner opens settings (secret!)

---

## ⚙️ HIDDEN FEATURES

### Secret Settings Access
- **Triple-tap** the top-left corner of the screen to access settings
- This allows you to:
  - View configured images
  - Test the form URL
  - See current configuration
  - (Note: Changes won't persist; edit AppConfiguration.swift for permanent changes)

### Full-Screen Mode
- Status bar is automatically hidden
- For true kiosk mode, enable **Guided Access** (see SETUP_CHECKLIST.md)

---

## 🎨 CUSTOMIZATION QUICK REFERENCE

All customization is in **AppConfiguration.swift**:

```swift
// Images to show
static let slideshowImages = ["slide1", "slide2", "slide3"]

// Time per slide (seconds)
static let slideInterval: TimeInterval = 5.0

// Your Google Form URL
static let signUpFormURL = "https://docs.google.com/..."

// Button text
static let signUpButtonText = "Sign Up for Mailing List"

// Form title
static let formTitle = "Sign Up"
```

---

## 🔧 TROUBLESHOOTING

### "Cannot find 'WaitingScreenView' in scope"
- Make sure all .swift files are added to the target
- Clean build folder: **⌘⇧K**
- Rebuild: **⌘R**

### Slideshow shows placeholder
- Add images to Assets.xcassets
- Update image names in AppConfiguration.swift
- Make sure names match exactly (case-sensitive!)

### Form doesn't load
- Check internet connection
- Verify Google Form URL is correct
- Make sure form is set to "Anyone with link can respond"
- Check INFO_PLIST_NOTES.md if using non-Google URLs

### Images look stretched/cropped
- Use images that match your device aspect ratio
- iPad: 4:3 ratio (e.g., 2048x1536)
- iPhone: 16:9 or 19.5:9 (e.g., 1920x1080)

---

## 📦 PROJECT STRUCTURE

```
ConConnect/
├── ConConnectApp.swift          # App entry point
├── ContentView.swift             # Main view (shows WaitingScreenView)
├── WaitingScreenView.swift      # Slideshow + Sign Up button
├── WebFormView.swift            # Web form display
├── AppConfiguration.swift       # All settings here!
├── SettingsView.swift           # Hidden settings panel
├── Assets.xcassets/             # ← ADD YOUR IMAGES HERE
├── README.md                    # Full documentation
├── SETUP_CHECKLIST.md          # Step-by-step guide
├── INFO_PLIST_NOTES.md         # Advanced config
└── BUILD_INSTRUCTIONS.md       # This file
```

---

## 🎯 READY FOR CONVENTION

Once you've completed Steps 1-4 above, your app is ready!

### Pre-Convention:
1. ✅ Images added and configured
2. ✅ Google Form created and URL added
3. ✅ App tested on your device
4. ✅ Device fully charged
5. ✅ Backup charger packed

### At Convention:
1. Launch app
2. (Optional) Enable Guided Access
3. Position device where people can interact
4. Let the slideshow run!
5. Visitors tap button to sign up

### After Convention:
1. Download responses from Google Forms
2. Import into your email marketing tool
3. Follow up with new subscribers!

---

## 🎊 YOU'RE DONE!

Your app is **ready to build**! Just:

1. Add your images to Assets.xcassets
2. Update AppConfiguration.swift with image names and form URL
3. Press ⌘R to build and run

**Good luck at your convention! 🚀**

---

## 💡 Need Help?

- Review README.md for detailed features
- Check SETUP_CHECKLIST.md for setup steps
- See INFO_PLIST_NOTES.md for advanced configuration

Questions? The code is well-commented and each view has clear responsibilities.
