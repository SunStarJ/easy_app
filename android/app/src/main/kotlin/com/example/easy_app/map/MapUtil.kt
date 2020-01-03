package com.example.easy_app.map

import android.content.Context
import com.amap.api.location.AMapLocationClient
import com.amap.api.location.AMapLocationClientOption
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MapUtil private constructor() {

    fun initLocationListener( events: EventChannel.EventSink?){
        mLocationClient?.setLocationListener {
            if(it.errorCode != 0){
                events?.error("-1",it.errorInfo,"")
            }else{
                var map = mapOf<String,Double>("lat" to it.latitude,"lng" to it.longitude)
                events?.success(map);
            }

        }
    }
    
    companion object {

        var eventChannel: EventChannel? = null

        private val ChannelName = "${javaClass.`package`.name}/locationUtil"

        val Instance: MapUtil by lazy {
            MapUtil()
        }

        @JvmStatic
        fun registerUtil(context: Context, registrar: DartExecutor) {
            MethodChannel(registrar, ChannelName).setMethodCallHandler { call, result ->
                when (call.method) {
                    "startLocation" -> Instance.startLocationService()
                }
            }
            eventChannel = EventChannel(registrar, "${javaClass.`package`.name}/locationUtilStream")
            eventChannel?.setStreamHandler(object :EventChannel.StreamHandler{
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    Instance.initLocationListener(events)
                }

                override fun onCancel(arguments: Any?) {

                }
            })
        }
    }


    var mLocationClient: AMapLocationClient? = null//定位实例


    ///初始化工具类
    fun initLocationUtil(context: Context) {
        print(ChannelName)
        val mLocationOption = AMapLocationClientOption()
        mLocationOption.isOnceLocationLatest = true //启用单次定位
        mLocationOption.isOnceLocation = true
        mLocationClient = AMapLocationClient(context);
        mLocationClient?.run {
            setLocationOption(mLocationOption)
            stopLocation()
        }
    }

    ///开始定位
    fun startLocationService() {
        print("开始定位")
        mLocationClient?.startLocation()
    }

}