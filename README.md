# media_drm_id

A Flutter plugin to securely retrieve the Android MediaDrm device ID (Widevine UUID).

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
  media_drm_id: ^0.0.1
Then run:

flutter pub get
Import the Package
import 'package:media_drm_id/media_drm_id.dart';
Usage Example
import 'package:flutter/material.dart';
import 'package:media_drm_id/media_drm_id.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _deviceId;

  @override
  void initState() {
    super.initState();
    _fetchDeviceId();
  }

  Future<void> _fetchDeviceId() async {
    String id;
    try {
      id = await MediaDrmId.getId();
    } catch (e) {
      id = 'Failed to get device ID: $e';
    }
    setState(() {
      _deviceId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('MediaDrm Device ID Example')),
        body: Center(
          child: Text(_deviceId ?? 'Loading...'),
        ),
      ),
    );
  }
}
Android Setup

No additional setup is required on the Android side since this plugin uses the official MediaDrm API.

Make sure your app's minSdkVersion is set to at least 29 (Android 10):

In android/app/build.gradle:

android {
    defaultConfig {
        minSdkVersion 29
        // other config
    }
}
How It Works (Technical Details)

This plugin accesses Android’s MediaDrm API with the Widevine UUID:

UUID WIDEVINE_UUID = new UUID(0xedef8ba979d64aceL, 0xa3c827dcd51d21edL);
MediaDrm mediaDrm = new MediaDrm(WIDEVINE_UUID);
byte[] deviceId = mediaDrm.getPropertyByteArray("deviceUniqueId");
The returned byte array is converted to a hex string for use in Flutter.

This ID is hardware-backed, consistent across app installs, and resistant to factory resets.

It’s ideal for apps requiring a persistent unique device identifier without requesting sensitive permissions.
```
