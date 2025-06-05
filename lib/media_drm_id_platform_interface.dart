import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'media_drm_id_method_channel.dart';

abstract class MediaDrmIdPlatform extends PlatformInterface {
  /// Constructs a MediaDrmIdPlatform.
  MediaDrmIdPlatform() : super(token: _token);

  static final Object _token = Object();

  static MediaDrmIdPlatform _instance = MethodChannelMediaDrmId();

  /// The default instance of [MediaDrmIdPlatform] to use.
  ///
  /// Defaults to [MethodChannelMediaDrmId].
  static MediaDrmIdPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MediaDrmIdPlatform] when
  /// they register themselves.
  static set instance(MediaDrmIdPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
