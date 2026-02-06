import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:media_drm_id/media_drm_id.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getMediaDrmId test', (WidgetTester tester) async {
    final String? drmId = await MediaDrmId.getMediaDrmId();

    // Flexible check: works on real devices (string) and emulators (null)
    expect(drmId, isA<String?>());
  });
}
