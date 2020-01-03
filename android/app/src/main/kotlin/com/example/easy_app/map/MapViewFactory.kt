package com.example.easy_app.map

import android.content.Context
import android.os.Bundle
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import java.util.*

class MapViewFactory:PlatformViewFactory {

    var map : MapView? = null
    private var message:BinaryMessenger? = null
    var bundle:Bundle? = null
    var registrar:DartExecutor?=null
    constructor(registrar: DartExecutor,savedInstanceState: Bundle?,message: BinaryMessenger?) : super(StandardMessageCodec.INSTANCE) {
        this.registrar = registrar
        bundle = savedInstanceState
        this.message = message
    }


    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val pamrams = args as Map<*, *>?
        map = MapView(context!!,registrar!!,message!!,pamrams)
        map!!.createView(bundle)
        return map!!
    }
}