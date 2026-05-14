# Required Info.plist Configuration

## ⚠️ Important: Internet Access Configuration

For the web form to load properly, you may need to configure App Transport Security settings.

### Option 1: Allow Specific Domain (Recommended)

If using Google Forms, add this to your Info.plist:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSExceptionDomains</key>
    <dict>
        <key>docs.google.com</key>
        <dict>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <false/>
            <key>NSIncludesSubdomains</key>
            <true/>
            <key>NSExceptionRequiresForwardSecrecy</key>
            <true/>
            <key>NSExceptionMinimumTLSVersion</key>
            <string>TLSv1.2</string>
        </dict>
    </dict>
</dict>
```

### Option 2: Trust All Domains (For Development Only)

⚠️ **Not recommended for App Store submission**

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

## How to Edit Info.plist

1. In Xcode's Project Navigator, find `Info.plist`
2. Right-click and choose "Open As" → "Source Code"
3. Add the configuration above inside the `<dict>` tag
4. Save the file

**Note:** Google Forms uses HTTPS, so it should work without any special configuration. Only add these settings if you encounter loading issues.

## Other Recommended Settings

### Prevent Device Sleep

Add to Info.plist:
```xml
<key>UIRequiresPersistentWiFi</key>
<true/>
```

### Supported Orientations

For convention use, you might want to lock to landscape or portrait:

**Portrait Only:**
```xml
<key>UISupportedInterfaceOrientations</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
</array>
```

**Landscape Only (Good for iPad stands):**
```xml
<key>UISupportedInterfaceOrientations~ipad</key>
<array>
    <string>UIInterfaceOrientationLandscapeLeft</string>
    <string>UIInterfaceOrientationLandscapeRight</string>
</array>
```

## Privacy Settings

If you plan to take photos or videos during the convention (future feature), add:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>We'd like to save images from your artwork to the photo library.</string>

<key>NSCameraUsageDescription</key>
<string>We'd like to use the camera to capture photos at the convention.</string>
```

**Note:** These are not required for the current app functionality.
