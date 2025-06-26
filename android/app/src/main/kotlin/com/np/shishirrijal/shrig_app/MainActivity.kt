package com.np.shishirrijal.shrig_app

import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.np.shishirrijal/device_info"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getDeviceInfo") {
                val deviceInfo = mapOf(
                    "platform" to "Android",
                    "model" to "${Build.BRAND} ${Build.MODEL}",
                    "osVersion" to "Android ${Build.VERSION.RELEASE} (SDK ${Build.VERSION.SDK_INT})"
                )
                result.success(deviceInfo)
            } else {
                result.notImplemented()
            }
        }
    }
}