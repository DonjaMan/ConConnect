# Company Banner Feature

## ✅ Custom Company Banner Added

Your ConConnect app now features a **customizable company banner** displayed at the top center of the slideshow screen!

---

## 🎨 Banner Specifications

### Layout:
- **Position:** Top center third of screen
- **Maximum Width:** 1/3 of screen width
- **Height:** Positioned in top third area
- **Alignment:** Center-aligned text
- **Background:** Transparent (artwork shows through)
- **Touch:** Non-interactive (doesn't block slideshow)

### Text Styling:

#### Company Name (Title):
- **Font Size:** Responsive (up to 48pt max)
- **Weight:** Bold
- **Color:** White
- **Shadow:** Black with 50% opacity, 8pt radius
- **Lines:** Up to 2 lines
- **Scale:** Automatically scales down if too long

#### Subtitle:
- **Font Size:** Responsive (up to 24pt max)  
- **Weight:** Medium
- **Color:** White with 90% opacity
- **Shadow:** Black with 50% opacity, 6pt radius
- **Lines:** Single line
- **Scale:** Automatically scales down if too long

---

## 📱 Visual Layout

```
┌─────────────────────────────────────────────────────────┐
│                                                         │
│              Your Company Name                          │ ← Banner
│           Artist • Creator • Innovator                  │
│                                                         │
│                                                         │
│              [Artwork Slideshow]                        │
│                                                         │
│                                                         │
│                                                         │
│          ┌──────────────────────────┐                   │
│          │ 📧 Sign Up for           │                   │
│          │ Mailing List             │                   │
│          └──────────────────────────┘              ⚙️   │
└─────────────────────────────────────────────────────────┘
      iPad Landscape - Company Banner at Top Center
```

---

## ⚙️ Customization

### Via Settings Panel:

1. **Tap gear icon** (⚙️) in bottom-right
2. Scroll to **"Company Banner"** section
3. Edit **Company Name** field
4. Edit **Subtitle** field
5. Changes save **automatically** as you type!
6. Tap **"Done"** to close settings
7. Banner updates **instantly** on slideshow

### Default Values:

```swift
Company Name: "Your Company Name"
Subtitle: "Artist • Creator • Innovator"
```

### Customization Examples:

#### Art Gallery:
```
Company Name: "Sunrise Art Gallery"
Subtitle: "Original Paintings & Sculptures"
```

#### Photographer:
```
Company Name: "Sarah Johnson Photography"
Subtitle: "Portrait • Wedding • Event"
```

#### Comic Artist:
```
Company Name: "Mike Chen Comics"
Subtitle: "Creator of Cosmic Heroes"
```

#### Craft Vendor:
```
Company Name: "Handmade by Emily"
Subtitle: "Jewelry • Ceramics • Fiber Art"
```

#### Multi-Artist:
```
Company Name: "Creative Collective"
Subtitle: "Fine Art • Design • Illustration"
```

---

## ✨ Features

### Persistence:
✅ **AppStorage Integration** - Saves automatically  
✅ **Persists Across Launches** - Remember your branding  
✅ **Instant Updates** - Changes reflect immediately  
✅ **Convention-Ready** - Set once, use everywhere  

### Responsiveness:
✅ **Adaptive Sizing** - Scales to fit iPad screen  
✅ **Multi-Line Support** - Company name can wrap (2 lines max)  
✅ **Auto-Scaling** - Text shrinks if too long  
✅ **Centered Layout** - Always perfectly centered  

### Visual Design:
✅ **High Contrast** - White text stands out on any artwork  
✅ **Drop Shadow** - Ensures readability  
✅ **Professional** - Clean, elegant typography  
✅ **Non-Intrusive** - Doesn't block artwork  

---

## 🎯 Best Practices

### Company Name:

**Good Examples:**
- ✅ "Jane Doe Art" (short and clear)
- ✅ "Cosmic Comics" (memorable brand)
- ✅ "Smith Family Pottery" (personal touch)
- ✅ "The Art Studio" (professional)

**Avoid:**
- ❌ Too long: "Jane Doe's Amazing Incredible Artwork and Design Studio LLC"
- ❌ All caps: "JANE DOE ART" (too aggressive)
- ❌ Special characters: "J@ne D☺e Art" (unprofessional)

### Subtitle:

**Good Examples:**
- ✅ "Watercolor • Acrylic • Mixed Media"
- ✅ "Original Fantasy Art Since 2010"
- ✅ "Comic Books • Illustrations • Prints"
- ✅ "Contemporary Abstract Paintings"

**Avoid:**
- ❌ Too long: "Watercolor, Acrylic, Oil, Mixed Media, Digital, and Sculpture Artist"
- ❌ Generic: "Art and Stuff"
- ❌ Sentence: "I make really cool artwork that you should buy"

### Formatting Tips:

1. **Use Bullet Separators:** `•` looks professional
   - Type: Option+8 on Mac
   - Or use: `/` or `|` as separators

2. **Keep it Concise:** Aim for 2-4 words in company name

3. **Highlight Specialties:** Use subtitle for what makes you unique

4. **Update Per Event:** Change subtitle for different conventions
   - Art show: "Fine Art Paintings"
   - Comic con: "Comic Books & Prints"
   - Craft fair: "Handmade Ceramics"

---

## 📐 Technical Details

### Size Calculations:

```swift
// Company Name
Font Size: min(screenWidth * 0.05, 48pt)
Max Width: screenWidth / 3
Max Lines: 2
Minimum Scale: 0.5 (shrinks to half size if needed)

// Subtitle
Font Size: min(screenWidth * 0.025, 24pt)
Max Width: screenWidth / 3
Max Lines: 1
Minimum Scale: 0.7 (shrinks to 70% if needed)
```

### iPad Pro 12.9" Example (2732px wide):
- Company Name: ~48pt (capped at maximum)
- Subtitle: ~24pt (capped at maximum)
- Max Width: ~911px (1/3 of screen)

### iPad Pro 11" Example (2388px wide):
- Company Name: ~48pt (capped at maximum)
- Subtitle: ~24pt (capped at maximum)  
- Max Width: ~796px (1/3 of screen)

---

## 🎨 Styling Customization (Advanced)

If you want to customize the banner appearance, edit `WaitingScreenView.swift`:

### Change Colors:

```swift
// Current (white text)
.foregroundStyle(.white)

// Options:
.foregroundStyle(.black)           // Black text
.foregroundStyle(.yellow)          // Yellow text
.foregroundStyle(.blue)            // Blue text
.foregroundStyle(Color(hex: "...")) // Custom color
```

### Change Shadow:

```swift
// Current
.shadow(color: .black.opacity(0.5), radius: 8, x: 0, y: 4)

// Stronger shadow
.shadow(color: .black.opacity(0.8), radius: 12, x: 0, y: 6)

// Softer shadow
.shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)

// Colored glow
.shadow(color: .blue.opacity(0.6), radius: 10, x: 0, y: 0)
```

### Add Background:

```swift
.background {
    RoundedRectangle(cornerRadius: 12)
        .fill(.black.opacity(0.3))
        .padding(.horizontal, -20)
        .padding(.vertical, -10)
}
```

### Change Font:

```swift
// Current (system font)
.font(.system(size: ..., weight: .bold))

// Serif font
.font(.system(size: ..., weight: .bold, design: .serif))

// Rounded font
.font(.system(size: ..., weight: .bold, design: .rounded))

// Custom font (if added to project)
.font(.custom("YourFontName", size: ...))
```

---

## 🎪 Convention Scenarios

### Scenario 1: Single Artist
```
Company Name: "Alex Rivers Art"
Subtitle: "Fantasy Illustrations & Prints"
```

### Scenario 2: Art Collective
```
Company Name: "Studio 42"
Subtitle: "Contemporary Art Collective"
```

### Scenario 3: Specialty Focus
```
Company Name: "Dragon Art Gallery"
Subtitle: "Original Dragon Paintings"
```

### Scenario 4: Multiple Mediums
```
Company Name: "Creative Expressions"
Subtitle: "Painting • Sculpture • Digital"
```

### Scenario 5: Brand Recognition
```
Company Name: "JaneDoeArt.com"
Subtitle: "Award-Winning Watercolors"
```

---

## 💾 Persistence

### Saved Automatically:

Both fields use **AppStorage** and persist across:
- ✅ App restarts
- ✅ Device reboots
- ✅ iOS updates
- ✅ Multiple conventions

### Reset to Default:

To reset banner to defaults, simply:
1. Open Settings
2. Delete text in Company Name field
3. Delete text in Subtitle field
4. App will show default placeholders

Or delete and reinstall app to clear all settings.

---

## 📊 Settings Summary

| Setting | Default | Persistence | Location |
|---------|---------|-------------|----------|
| **Company Name** | "Your Company Name" | AppStorage | Settings → Company Banner |
| **Subtitle** | "Artist • Creator • Innovator" | AppStorage | Settings → Company Banner |

---

## 🆘 Troubleshooting

### Banner text too small?
- Text auto-sizes based on screen width
- Shorten your company name for larger display
- Max size is 48pt for name, 24pt for subtitle

### Banner text too long/cut off?
- Keep company name under 25 characters
- Keep subtitle under 40 characters
- Text will auto-scale down, but may become too small

### Can't see banner on dark artwork?
- White text with drop shadow should be visible
- Consider adding background (see Advanced section)
- Or use lighter/brighter artwork

### Banner position wrong?
- Banner is in top center third (by design)
- Positioned 40px from top
- To adjust, edit WaitingScreenView.swift

### Want to hide banner?
- Set both fields to empty strings in Settings
- Banner will still show but with no text

---

## ✅ Summary

Your app now features:

✅ **Customizable company banner** at top of slideshow  
✅ **Two text fields** - Company name + subtitle  
✅ **Auto-sizing** - Adapts to iPad screen size  
✅ **Persistent** - Saved automatically via AppStorage  
✅ **Professional styling** - Drop shadows, proper sizing  
✅ **Convention-ready** - Perfect for branding your booth  

**Configure your banner in Settings and make your booth stand out!** 🎨✨
