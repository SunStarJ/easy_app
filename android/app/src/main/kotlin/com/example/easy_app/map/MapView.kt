package com.example.easy_app.map

import android.content.Context
import android.os.Bundle
import android.view.View
import android.widget.Toast
import com.amap.api.maps.AMap
import com.amap.api.maps.CameraUpdate
import com.amap.api.maps.CameraUpdateFactory
import com.amap.api.maps.MapView
import com.amap.api.maps.model.CameraPosition
import com.amap.api.maps.model.LatLng
import com.amap.api.maps.model.MarkerOptions
import com.amap.api.maps.model.animation.Animation
import com.amap.api.maps.model.animation.RotateAnimation
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import java.lang.reflect.Method
import android.R.attr.end
import android.R.attr.start
import android.content.Intent
import com.amap.api.maps.model.Poi
import com.amap.api.navi.*
import com.amap.api.navi.model.AMapNaviLocation
import com.example.easy_app.NavigationActivity
import com.example.easy_app.Util


class MapView(var mContext: Context, registrar: DartExecutor, var messenger: BinaryMessenger, var params: Map<*, *>?) : PlatformView, MethodChannel.MethodCallHandler {

    private var eventChannel: EventChannel? = null

    private var methodChannel: MethodChannel? = null

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "goto" -> {
                mContext.startActivity(Intent(mContext, NavigationActivity::class.java).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
            }
            "destroy" -> mapView.onDestroy()
        }
    }

    val amap: AMap by lazy {
        mapView.map
    }

    val mapView: MapView by lazy {
        MapView(mContext)
    }

    init {
        methodChannel = MethodChannel(registrar, "${javaClass.`package`.name}/mapViewMethod")
        methodChannel?.setMethodCallHandler(this)
        eventChannel = EventChannel(registrar, "${javaClass.`package`.name}/mapViewEvent")
    }

    fun createView(savedInstanceState: Bundle?) {
        mapView.onCreate(savedInstanceState)
        amap.mapType = if (Util.getDarkModeStatus(mContext)) 3 else 1
        amap.uiSettings.run {
            isZoomControlsEnabled = false
            params?.run {
                if (!isNullOrEmpty()) {
                    var lat = this["lat"] as Double
                    var lng = this["lng"] as Double
                    var position = LatLng(lat, lng)
                    var carmeraUpdate = CameraUpdateFactory.newCameraPosition(CameraPosition(position, 14f, 0f, 0f))
                    amap.animateCamera(carmeraUpdate)
                    var marker = amap.addMarker(MarkerOptions().position(position).title("月野兔健身").snippet("DefaultMarker"))
                }
            }

        }

    }

    override fun getView(): View = mapView;

    override fun dispose() {
        mapView.onDestroy()
    }
}