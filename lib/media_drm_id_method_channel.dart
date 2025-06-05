import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'media_drm_id_platform_interface.dart';

/// An implementation of [MediaDrmIdPlatform] that uses method channels.
class MethodChannelMediaDrmId extends MediaDrmIdPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('media_drm_id');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
