package com.example.easy_app

import android.os.Bundle
import androidx.annotation.NonNull;
import com.example.easy_app.map.MapUtil
import com.example.easy_app.map.MapView
import com.example.easy_app.map.MapViewFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
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
        mapView =  MapViewFactory(flutterEngine.dartExecutor, bundle, flutterEngine.dartExecutor.binaryMessenger)
        flutterEngine.platformViewsController.registry.registerViewFactory("com.example.easy_app.map/mapView",mapView)

        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }

    override fun onPause() {
        super.onPause()
        mapView?.map?.mapView?.onPause()
    }

    override fun onResume() {
        super.onResume()
        mapView?.map?.mapView?.onResume()
    }

    override fun onDestroy() {
        super.onDestroy()
        mapView?.map?.mapView?.onDestroy()
    }

}
