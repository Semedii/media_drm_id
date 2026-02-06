# media_drm_id

A Flutter plugin to retrieve the Android Widevine MediaDrm device-unique ID as a hexadecimal string.

---

## Overview

Starting from Android 10 (API level 29), access to traditional hardware identifiers like IMEI and serial number has been heavily restricted for privacy reasons. To uniquely identify devices, Android provides the **MediaDrm API** which returns a consistent, unique device identifier tied to the hardware’s DRM capabilities.

This plugin exposes the MediaDrm device ID in Flutter apps, enabling developers to:

- Obtain a reliable unique device ID on Android 10+
- Avoid deprecated or restricted device ID methods
- Use a hardware-backed, non-resettable identifier suitable for licensing, anti-fraud, or device management purposes

---

## Additional Notes

- The MediaDrm device ID does not change if the app is uninstalled or reinstalled.
- It is hardware-backed and survives factory resets in most cases, making it reliable for persistent device identification.

---

## Features

- Retrieve MediaDrm device ID using Widevine UUID
- Supports Android 10 (API 29) and above
- Lightweight and easy-to-use Flutter plugin
- No additional native setup required

---

## Getting Started

### Installation

Add `media_drm_id` as a dependency in your `pubspec.yaml`:

```yaml
dependencies:
  media_drm_id: ^1.0.0
```

Then run:

```bash
flutter pub get
```

Import the Package

```dart
import 'package:media_drm_id/media_drm_id.dart';
```

Usage Example

```dart
import 'package:flutter/material.dart';

import 'package:media_drm_id/media_drm_id.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _drmId = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchDrmId();
  }

  Future<void> _fetchDrmId() async {
    String drmId = 'Unknown';

    try {
      final String? id = await MediaDrmId.getMediaDrmId();
      if (id != null && id.isNotEmpty) {
        drmId = id;
      } else {
        drmId = 'No DRM ID returned (device may not support Widevine L3)';
      }
    } on PlatformException catch (e) {
      drmId = 'Error: ${e.code} - ${e.message}';
    } catch (e) {
      drmId = 'Unexpected error: $e';
    }

    if (!mounted) return;

    setState(() {
      _drmId = drmId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Media DRM ID Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SelectableText(
              'Media DRM ID:\n$_drmId',
              style: const TextStyle(fontSize: 16, fontFamily: 'monospace'),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _fetchDrmId,
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
```

Platform Support

- Android: Supported (tested on API 21+; Widevine L3 required for reliable results)
- iOS / Web / Desktop: Not supported (MediaDrm is Android-specific)

No minSdkVersion restriction needed — works down to API 18, but best results on modern devices.

Important Notes & Limitations

- Returns a lowercase hex string (typically 32–64 characters) on supported devices.
- Returns null if:
  - Widevine is not supported/provisioned
  - Device lacks L3 security level
  - Rare errors occur

- Common on emulators: Usually null (no hardware Widevine).
- The ID is persistent: Survives app uninstall/reinstall and often factory resets.
- Privacy: This is a hardware identifier — use responsibly and comply with privacy laws (e.g., disclose in policy if used for tracking).

How It Works (Technical Details)
The plugin uses Android's MediaDrm with the official Widevine UUID:

```kotlin
val widevineUUID = UUID.fromString("edef8ba9-79d6-4ace-a3c8-27dcd51d21ed")
val mediaDrm = MediaDrm(widevineUUID)
val deviceIdBytes = mediaDrm.getPropertyByteArray(MediaDrm.PROPERTY_DEVICE_UNIQUE_ID)
```

This ID is hardware-backed, consistent across app installs, and resistant to factory resets.

It’s ideal for apps requiring a persistent unique device identifier without requesting sensitive permissions.
