import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    initDrmId();
  }

  Future<void> initDrmId() async {
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
        appBar: AppBar(title: const Text('Media DRM ID Plugin Example')),
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
          onPressed: initDrmId,
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
