package com.example.easy_app

import com.example.easy_app.map.MapUtil
import io.flutter.app.FlutterApplication

class App:FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        MapUtil.Instance.initLocationUtil(applicationContext)
    }
}