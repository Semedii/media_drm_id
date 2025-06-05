import 'package:flutter_test/flutter_test.dart';
import 'package:media_drm_id/media_drm_id.dart';
import 'package:media_drm_id/media_drm_id_platform_interface.dart';
import 'package:media_drm_id/media_drm_id_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMediaDrmIdPlatform
    with MockPlatformInterfaceMixin
    implements MediaDrmIdPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MediaDrmIdPlatform initialPlatform = MediaDrmIdPlatform.instance;

  test('$MethodChannelMediaDrmId is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMediaDrmId>());
  });

  test('getPlatformVersion', () async {
    MediaDrmId mediaDrmIdPlugin = MediaDrmId();
    MockMediaDrmIdPlatform fakePlatform = MockMediaDrmIdPlatform();
    MediaDrmIdPlatform.instance = fakePlatform;

    expect(await mediaDrmIdPlugin.getPlatformVersion(), '42');
  });
}
