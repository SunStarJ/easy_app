package com.example.easy_app

import android.graphics.Color
import android.os.Build
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.view.WindowManager
import com.amap.api.navi.AMapNavi
import com.amap.api.navi.enums.NaviType
import kotlinx.android.synthetic.main.activity_navigation_page.*

class NavigationPageActivity : AppCompatActivity() {

    val mAmapNavi by lazy {
        AMapNavi.getInstance(this.applicationContext)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_navigation_page)
        initPage()
        noTityle()
        navi_map.onCreate(savedInstanceState)
    }

    private fun noTityle() {
        if (Build.VERSION.SDK_INT >= 21) {//21表示5.0
            val window = window
            window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
            window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or View.SYSTEM_UI_FLAG_LAYOUT_STABLE
            window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
            window.statusBarColor = Color.TRANSPARENT
        } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {//19表示4.4
            window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
            //虚拟键盘也透明
            //getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION);
        }
    }

    override fun onResume() {
        super.onResume()
        navi_map.onResume()
    }

    override fun onPause() {
        super.onPause()
        navi_map.onPause()
    }

    override fun onDestroy() {
        super.onDestroy()
        navi_map.onDestroy()
    }

    private fun initPage() {
        navi_map.setOnMapLoadedListener {
            mAmapNavi.startNavi(NaviType.GPS)
        }
    }
}
