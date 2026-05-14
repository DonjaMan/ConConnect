# Banner Customization Features

## ✅ Advanced Banner Controls Added

Your ConConnect app now features **fully customizable banner styling** with adjustable text sizes and an optional glass frame background!

---

## 🎨 New Customization Options

### Text Size Controls:

1. **Company Name Size**
   - Range: 24pt to 72pt
   - Step: 2pt increments
   - Default: 48pt
   - Persists via AppStorage

2. **Subtitle Size**
   - Range: 12pt to 48pt
   - Step: 2pt increments
   - Default: 24pt
   - Persists via AppStorage

### Glass Frame Background:

3. **Glass Frame Toggle**
   - ON: Adds frosted glass background (.ultraThinMaterial)
   - OFF: Transparent background (default)
   - Includes drop shadow for depth
   - Rounded corners (16pt radius)
   - Persists via AppStorage

---

## ⚙️ How to Customize

### In Settings Panel:

1. **Tap gear icon** (⚙️) in bottom-right corner
2. Scroll to **"Company Banner"** section
3. **Edit text fields:**
   - Company Name
   - Subtitle
4. **Adjust text sizes:**
   - Drag "Company Name Size" slider (24-72pt)
   - Drag "Subtitle Size" slider (12-48pt)
5. **Toggle glass frame:**
   - Switch ON for frosted glass background
   - Switch OFF for transparent (default)
6. Changes save **automatically**!
7. Tap **"Done"** to see changes on slideshow

---

## 📱 Visual Comparison

### Without Glass Frame (Default):
```
┌──────────────────────────────────────────────┐
│                                              │
│         Your Company Name        ← White text│
│      Artist • Creator • Innovator   on artwork│
│                                              │
│         [Artwork shows through]              │
```

### With Glass Frame (Enabled):
```
┌──────────────────────────────────────────────┐
│                                              │
│   ┌────────────────────────────┐            │
│   │  Your Company Name         │ ← Frosted  │
│   │ Artist • Creator • Innovator│   glass   │
│   └────────────────────────────┘            │
│         [Artwork blurred behind glass]       │
```

---

## 🎯 Glass Frame Features

### Visual Properties:

- **Material:** `.ultraThinMaterial` (iOS frosted glass effect)
- **Shape:** Rounded rectangle with 16pt corner radius
- **Shadow:** Black 30% opacity, 15pt blur, 8pt offset
- **Padding:** 30px horizontal, 20px vertical
- **Blur:** Blurs artwork behind banner for readability

### Benefits:

✅ **Enhanced Readability** - Text stands out on any artwork  
✅ **Professional Look** - Modern, polished appearance  
✅ **Adaptive Blur** - Automatically blurs artwork behind  
✅ **Dark/Light Aware** - Material adapts to system appearance  
✅ **Depth Effect** - Drop shadow creates floating appearance  

---

## 📊 Text Size Ranges

### Company Name:

| Size | Use Case |
|------|----------|
| **24-32pt** | Subtle branding, long names |
| **34-48pt** | Default, balanced appearance |
| **50-60pt** | Bold, attention-grabbing |
| **62-72pt** | Maximum impact, short names |

### Subtitle:

| Size | Use Case |
|------|----------|
| **12-16pt** | Small, understated |
| **18-24pt** | Default, readable |
| **26-36pt** | Prominent tagline |
| **38-48pt** | Maximum visibility |

---

## 💡 Styling Recommendations

### Small Booth Display:
```
Company Name: 40pt
Subtitle: 20pt
Glass Frame: OFF (let artwork shine)
```

### Large Convention Hall:
```
Company Name: 64pt
Subtitle: 36pt
Glass Frame: ON (stand out from distance)
```

### Detailed Artwork Background:
```
Company Name: 48pt
Subtitle: 24pt
Glass Frame: ON (ensure readability)
```

### Minimalist/Clean Artwork:
```
Company Name: 52pt
Subtitle: 26pt
Glass Frame: OFF (complement clean aesthetic)
```

### Dark/Complex Artwork:
```
Company Name: 56pt
Subtitle: 30pt
Glass Frame: ON (text clarity on dark images)
```

---

## 🎨 Design Combinations

### Modern & Sleek:
```
Company Name: "STUDIO 42" (56pt)
Subtitle: "Contemporary Art" (28pt)
Glass Frame: ON
```

### Classic & Elegant:
```
Company Name: "Jane Doe Gallery" (48pt)
Subtitle: "Fine Art Since 1995" (22pt)
Glass Frame: OFF
```

### Bold & Impactful:
```
Company Name: "DRAGON ART" (72pt)
Subtitle: "Epic Fantasy" (40pt)
Glass Frame: ON
```

### Subtle & Professional:
```
Company Name: "Sarah Chen Photography" (36pt)
Subtitle: "Portrait • Wedding • Event" (18pt)
Glass Frame: OFF
```

---

## 🔧 Technical Details

### Implementation:

**WaitingScreenView.swift:**
```swift
// Text sizes from AppStorage
.font(.system(size: companyNameSize, weight: .bold))
.font(.system(size: subtitleSize, weight: .medium))

// Conditional glass background
.background {
    if glassFrameEnabled {
        RoundedRectangle(cornerRadius: 16)
            .fill(.ultraThinMaterial)
            .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 8)
    }
}
```

**SettingsView.swift:**
```swift
// Text size sliders
Slider(value: $companyNameSize, in: 24...72, step: 2)
Slider(value: $subtitleSize, in: 12...48, step: 2)

// Glass frame toggle
Toggle(isOn: $glassFrameEnabled) {
    Text("Glass Frame Background")
}
```

---

## 💾 Persistence

All customization settings persist via AppStorage:

| Setting | Range | Default | Key |
|---------|-------|---------|-----|
| **Company Name Size** | 24-72pt | 48pt | `companyNameSize` |
| **Subtitle Size** | 12-48pt | 24pt | `subtitleSize` |
| **Glass Frame** | ON/OFF | OFF | `glassFrameEnabled` |

Persists across:
- ✅ App restarts
- ✅ Device reboots
- ✅ iOS updates

---

## 🎪 Convention Scenarios

### Scenario 1: Outdoor Art Fair (Bright Sunlight)
```
Problem: Text hard to see in bright light
Solution: 
  - Increase sizes: 64pt name, 32pt subtitle
  - Enable glass frame for contrast
  - Result: Highly visible from distance
```

### Scenario 2: Indoor Comic Con (Varied Lighting)
```
Problem: Need to stand out among many booths
Solution:
  - Bold sizes: 68pt name, 38pt subtitle
  - Enable glass frame
  - Result: Eye-catching, professional
```

### Scenario 3: Gallery Opening (Sophisticated)
```
Problem: Want elegant, not overpowering
Solution:
  - Moderate sizes: 44pt name, 22pt subtitle
  - Disable glass frame
  - Result: Refined, lets artwork speak
```

### Scenario 4: Craft Fair (Personal Touch)
```
Problem: Want approachable, friendly vibe
Solution:
  - Medium sizes: 48pt name, 24pt subtitle
  - Disable glass frame
  - Result: Welcoming, accessible
```

---

## 🧪 Testing Your Design

### Quick Test Checklist:

1. **Set text sizes** in Settings
2. **Toggle glass frame** ON
3. **Close Settings** and view slideshow
4. **Check readability** on different artworks
5. **View from distance** (6-10 feet away)
6. **Toggle glass frame** OFF
7. **Compare** which looks better
8. **Adjust sizes** if needed
9. **Save final settings**

### Readability Test:

- Can you read company name from 10 feet away? ✅
- Is subtitle clear on dark/light artworks? ✅
- Does glass frame help or distract? ✅
- Are sizes balanced (name larger than subtitle)? ✅

---

## 🎨 Glass Frame Material

### .ultraThinMaterial Properties:

- **iOS Light Mode:** Subtle white frosted glass
- **iOS Dark Mode:** Subtle dark frosted glass
- **Transparency:** Allows artwork colors to show through
- **Blur:** Gaussian blur behind material
- **Vibrancy:** Text appears vibrant against blur

### When to Use Glass Frame:

✅ **Use When:**
- Artwork is complex/busy
- Dark or low-contrast backgrounds
- Need maximum readability
- Want modern, polished look
- Viewing from distance

❌ **Skip When:**
- Artwork is clean/minimalist
- Backgrounds are already light
- Want artwork to be focal point
- Prefer subtle branding
- Close-up viewing only

---

## 📏 Size Guidelines

### Company Name Length vs. Size:

| Name Length | Recommended Size |
|-------------|------------------|
| **Short (1-10 chars)** | 60-72pt |
| **Medium (11-20 chars)** | 44-56pt |
| **Long (21-30 chars)** | 32-42pt |
| **Very Long (30+ chars)** | 24-32pt |

### Subtitle Length vs. Size:

| Subtitle Length | Recommended Size |
|-----------------|------------------|
| **Short (1-15 chars)** | 32-48pt |
| **Medium (16-30 chars)** | 22-30pt |
| **Long (31-45 chars)** | 16-20pt |
| **Very Long (45+ chars)** | 12-16pt |

---

## 🆘 Troubleshooting

### Text too small to read?
- Increase size sliders
- Recommended minimum: 36pt name, 20pt subtitle

### Text too large/overwhelming?
- Decrease size sliders
- Recommended maximum: 64pt name, 36pt subtitle

### Glass frame looks wrong?
- Try toggling OFF for cleaner look
- Check if material color suits your artwork

### Text cut off?
- Reduce text size
- Shorten company name/subtitle text
- Frame maxWidth is 1/3 screen (automatic)

### Glass frame too subtle?
- This is by design (.ultraThinMaterial)
- Effect is elegant, not heavy
- Try on different artworks to see variation

---

## ✅ Summary

Your banner now supports:

✅ **Adjustable company name size** (24-72pt)  
✅ **Adjustable subtitle size** (12-48pt)  
✅ **Optional glass frame background** (ON/OFF toggle)  
✅ **All settings persist** via AppStorage  
✅ **Instant preview** when closing Settings  
✅ **Professional appearance** with modern materials  

**Customize your banner to perfectly match your brand and booth setup!** 🎨✨
