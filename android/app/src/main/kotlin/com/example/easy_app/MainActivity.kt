package com.example.easy_app

import android.content.Intent
import android.os.Bundle
import android.provider.Settings
import android.util.Log
import androidx.annotation.NonNull;
import com.example.easy_app.map.MapUtil
import com.example.easy_app.map.MapView
import com.example.easy_app.map.MapViewFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformViewRegistry
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    var bundle: Bundle? = null

    var mapView : MapViewFactory?= null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        bundle = savedInstanceState
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapUtil.registerUtil(this, flutterEngine.dartExecutor)
        MethodChannel(flutterEngine.dartExecutor,"message").setMethodCallHandler { call, result ->
            when(call.method){
                "getInitMessage"->{
                    result.success(mapOf("message" to "id","type" to 1))
                }
            }
        }
        Message.instance.initChannel(this,flutterEngine.dartExecutor);
        mapView =  MapViewFactory(flutterEngine.dartExecutor, bundle, flutterEngine.dartExecutor.binaryMessenger)
        flutterEngine.platformViewsController.registry.registerViewFactory("com.example.easy_app.map/mapView",mapView)
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        Log.i("Flutter-Native:","加载完成")
    }


    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
    }

    override fun onPause() {
        super.onPause()
        mapView?.map?.mapView?.onPause()
    }

    override fun onResume() {
        super.onResume()
        checkBundle()
        mapView?.map?.mapView?.onResume()
    }

    private fun checkBundle() {
        var bun = intent.extras;
        bun?.run {
            keySet().forEach {
                this.get(it)?.run {
                    Log.i(it,this.toString())
                }
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        mapView?.map?.mapView?.onDestroy()
    }

}
