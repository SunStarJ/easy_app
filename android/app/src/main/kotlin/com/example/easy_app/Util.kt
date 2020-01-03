package com.example.easy_app

import android.content.Context
import android.content.res.Configuration

object Util{
    //检查当前系统是否已开启暗黑模式
    fun getDarkModeStatus(context:Context):Boolean {
        var mode = context.getResources().getConfiguration().uiMode and Configuration.UI_MODE_NIGHT_MASK;
        return mode == Configuration.UI_MODE_NIGHT_YES;
    }
}