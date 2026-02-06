package com.example.media_drm_id  // Change if needed (e.g., com.yourname.media_drm_id)

import android.media.MediaDrm
import android.media.NotProvisionedException
import android.media.UnsupportedSchemeException
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.UUID

class MediaDrmIdPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "media_drm_id")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getMediaDrmId") {
      val widevineUUID = UUID.fromString("edef8ba9-79d6-4ace-a3c8-27dcd51d21ed")
      try {
        val mediaDrm = MediaDrm(widevineUUID)
        try {
          val deviceIdBytes = mediaDrm.getPropertyByteArray(MediaDrm.PROPERTY_DEVICE_UNIQUE_ID)
          val hexId = deviceIdBytes.joinToString("") { String.format("%02x", it.toInt() and 0xFF) }
          result.success(hexId)
        } finally {
          mediaDrm.release()
        }
      } catch (e: UnsupportedSchemeException) {
        result.error("UNSUPPORTED_SCHEME", "Widevine not supported on this device", null)
      } catch (e: NotProvisionedException) {
        result.error("NOT_PROVISIONED", "Device not provisioned for Widevine", null)
      } catch (e: Exception) {
        result.error("DRM_ERROR", "Failed to get MediaDrm ID: ${e.message}", null)
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}