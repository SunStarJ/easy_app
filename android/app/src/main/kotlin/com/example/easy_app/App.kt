package com.example.easy_app

import android.content.Context
import android.util.Log
import com.example.easy_app.map.MapUtil
import com.umeng.commonsdk.UMConfigure
import com.umeng.message.IUmengRegisterCallback
import com.umeng.message.PushAgent
import com.umeng.message.UmengNotificationClickHandler
import com.umeng.message.entity.UMessage
import io.flutter.app.FlutterApplication

class App:FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        MapUtil.Instance.initLocationUtil(applicationContext)
        initUmeng()
    }

    ///注册有梦
    private fun initUmeng() {
        UMConfigure.init(applicationContext, "5bda5046b465f5f632000092", "", UMConfigure.DEVICE_TYPE_PHONE, "95387292a0c5fa9cb4df1cba9693e068")
//        var notificationClick = object:UmengNotificationClickHandler(){
//            override fun launchApp(p0: Context?, p1: UMessage?) {
//                super.launchApp(p0, p1)
//                p1?.extra?.keys?.forEach {
//                    Log.i("umeng",it)
//                }
//
//            }
//        }
        PushAgent.getInstance(applicationContext).run {
            ///注册
            register(object :IUmengRegisterCallback{
                override fun onSuccess(p0: String?) {
                    Log.i("umengLogin:","$p0")
                }

                override fun onFailure(p0: String?, p1: String?) {
                    Log.e("umengLogin:", "注册失败：-------->  s:$p0,s1:$p1");
                }
            })
            ///设置点击获取数据
            setNotificationClickHandler { context, uMessage ->
                uMessage?.extra?.keys?.forEach {
                    Log.i("umeng",it)
                }
            }
        }

    }
}