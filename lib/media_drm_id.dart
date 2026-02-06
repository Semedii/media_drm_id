import 'dart:async';

import 'package:flutter/services.dart';

class MediaDrmId {
  static const MethodChannel _channel = MethodChannel('media_drm_id');

  /// Gets the Widevine device-unique ID as a lowercase hex string.
  /// Returns null if unavailable (e.g., no Widevine support, error, etc.).
  static Future<String?> getMediaDrmId() async {
    try {
      final String? id = await _channel.invokeMethod('getMediaDrmId');
      return id;
    } on PlatformException {
      return null;
    }
  }
}
