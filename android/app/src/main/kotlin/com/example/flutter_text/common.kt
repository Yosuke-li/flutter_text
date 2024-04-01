package com.example.flutter_text

import com.hjq.permissions.XXPermissions
import android.content.Context
import android.os.Handler
import android.os.Looper

// intent action, extra
const val ACT_REQUEST_MEDIA_PROJECTION = "REQUEST_MEDIA_PROJECTION"
const val ACT_INIT_MEDIA_PROJECTION_AND_SERVICE = "INIT_MEDIA_PROJECTION_AND_SERVICE"
const val ACT_LOGIN_REQ_NOTIFY = "LOGIN_REQ_NOTIFY"
const val EXT_INIT_FROM_BOOT = "EXT_INIT_FROM_BOOT"
const val EXT_MEDIA_PROJECTION_RES_INTENT = "MEDIA_PROJECTION_RES_INTENT"
const val EXT_LOGIN_REQ_NOTIFY = "LOGIN_REQ_NOTIFY"

fun requestPermission(context: Context, type: String) {
    XXPermissions.with(context)
            .permission(type)
            .request { _, all ->
                if (all) {
                    Handler(Looper.getMainLooper()).post {
                        MainActivity.flutterMethodChannel?.invokeMethod(
                                "on_android_permission_result",
                                mapOf("type" to type, "result" to all)
                        )
                    }
                }
            }
}