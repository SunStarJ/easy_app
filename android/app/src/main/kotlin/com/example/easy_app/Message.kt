package com.example.easy_app

import android.content.Context
import android.util.Log
import com.umeng.message.PushAgent
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.EventChannel

class Message private constructor(){

    var eventChannel:EventChannel? = null
    var events:EventChannel.EventSink? = null;
    
    fun  sendMessage (){
        events?.success("123123123")
    }
    
    fun initChannel(c:Context,registrar: DartExecutor){
        eventChannel = EventChannel(registrar.binaryMessenger,"com.example.easy_app.message")
        eventChannel?.setStreamHandler(object:EventChannel.StreamHandler{
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                this@Message.events = events;
            }

            override fun onCancel(arguments: Any?) {

            }
        })

    }



    companion object{
        val instance:Message by lazy {
            Message()
        }
    }
}