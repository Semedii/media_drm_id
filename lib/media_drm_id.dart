import 'package:flutter/services.dart';

class MediaDrmId {
  static const MethodChannel _channel = MethodChannel('media_drm_id');

  static Future<String?> get deviceId async {
    try {
      return await _channel.invokeMethod<String>('getMediaDrmId');
    } on PlatformException {
      return null;
    }
  }
}
