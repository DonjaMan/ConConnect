# Setup Checklist for ConConnect

## ✅ Before Your Convention

### 1. Add Your Images
- [ ] Open `Assets.xcassets` in Xcode
- [ ] Drag and drop 5-10 portfolio/artwork images
- [ ] Note the names you give each image
- [ ] Update `AppConfiguration.swift` with image names

### 2. Create Google Form
- [ ] Go to https://docs.google.com/forms
- [ ] Create a new form with fields:
  - Name (short answer)
  - Email (short answer)
  - Phone (short answer - optional)
  - Comments (paragraph - optional)
- [ ] Click Send → Get link
- [ ] Copy the form URL

### 3. Configure the App
- [ ] Open `AppConfiguration.swift`
- [ ] Replace image names in `slideshowImages` array
- [ ] Paste your Google Form URL into `signUpFormURL`
- [ ] Adjust `slideInterval` if desired (default: 5 seconds)

### 4. Test Everything
- [ ] Build and run the app (⌘R)
- [ ] Verify all images appear in slideshow
- [ ] Tap "Sign Up for Mailing List" button
- [ ] Verify Google Form loads correctly
- [ ] Submit a test entry
- [ ] Check Google Form responses to see test entry

### 5. Device Preparation
- [ ] Charge device to 100%
- [ ] Bring charging cable and power adapter
- [ ] Test internet connectivity at convention venue
- [ ] Consider enabling Guided Access (locks to app only)

### 6. Optional: Enable Guided Access
- [ ] Go to Settings → Accessibility → Guided Access
- [ ] Turn ON Guided Access
- [ ] Set a passcode you'll remember
- [ ] At convention: Open app, triple-click side button, tap Start

## 🎯 At The Convention

### Setup
1. Position device where people can interact comfortably
2. Plug in charger
3. Launch ConConnect app
4. (Optional) Enable Guided Access with triple-click

### During the Event
- Slideshow runs automatically
- Visitors tap the button to sign up
- They fill out the form
- They tap "Done" when finished
- App returns to slideshow for next person

### Monitoring
- Check Google Form responses periodically
- Ensure device stays charged
- Watch for any WiFi connectivity issues

## 📊 After The Convention

### Export Your Leads
1. Open your Google Form
2. Click "Responses" tab
3. Click three-dot menu → "Download responses (.csv)"
4. Import into your email marketing tool (Mailchimp, etc.)

### Review Performance
- Total sign-ups collected
- Time periods with most activity
- Any technical issues to address for next time

## 🔧 Quick Fixes

**Slideshow not showing images?**
- Check that image names in AppConfiguration match Assets.xcassets exactly

**Form not loading?**
- Verify internet connection
- Test the URL in Safari
- Make sure form is set to "Anyone with the link can respond"

**Button not responding?**
- Try restarting the app
- Check if Guided Access is blocking touches

**Device sleeping?**
- Go to Settings → Display & Brightness → Auto-Lock → Never
- Or keep interacting with device periodically

## 💡 Pro Tips

1. **Create multiple forms**: One per convention/event to track where leads came from
2. **Use QR codes**: Create a backup QR code poster in case device has issues
3. **Bring backup**: Second device with app installed just in case
4. **Practice pitch**: Know what to say when directing people to sign up
5. **Follow up fast**: Email new subscribers within 24 hours while you're fresh in their mind

---

## Need Help?

Check README.md for detailed documentation and customization options.
