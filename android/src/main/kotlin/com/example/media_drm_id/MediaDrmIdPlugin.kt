package com.example.media_drm_id

import android.media.MediaDrm
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.*

class MediaDrmIdPlugin: FlutterPlugin, MethodChannel.MethodCallHandler {
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "media_drm_id")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
    if (call.method == "getMediaDrmId") {
      try {
        val widevineUUID = UUID.fromString("edef8ba9-79d6-4ace-a3c8-27dcd51d21ed")
        val mediaDrm = MediaDrm(widevineUUID)
        val deviceId = mediaDrm.getPropertyByteArray(MediaDrm.PROPERTY_DEVICE_UNIQUE_ID)
        val hexId = deviceId.joinToString("") { String.format("%02x", it) }
        result.success(hexId)
      } catch (e: Exception) {
        result.error("UNAVAILABLE", "Could not get MediaDrm ID", null)
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
