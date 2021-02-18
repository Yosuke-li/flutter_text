package com.example.flutter_text

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import com.tekartik.sqflite.SqflitePlugin
import com.baseflow.permissionhandler.PermissionHandlerPlugin
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        SqflitePlugin.registerWith(registrarFor("com.tekartik.sqflite.SqflitePlugin"));
        SharedPreferencesPlugin.registerWith(registrarFor("plugins.flutter.io/shared_preferences"));
        PermissionHandlerPlugin.registerWith(registrarFor("com.baseflow.permissionhandler.PermissionHandlerPlugin"));

    }
}
