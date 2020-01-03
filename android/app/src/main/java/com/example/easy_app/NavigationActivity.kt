package com.example.easy_app

import android.content.Intent
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.view.View
import android.view.WindowManager
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.constraintlayout.widget.ConstraintLayout
import com.amap.api.location.AMapLocationClient
import com.amap.api.location.AMapLocationClientOption
import com.amap.api.maps.AMap
import com.amap.api.maps.AMapUtils.DRIVING_DEFAULT
import com.amap.api.maps.CameraUpdateFactory
import com.amap.api.maps.model.BitmapDescriptorFactory
import com.amap.api.maps.model.CameraPosition
import com.amap.api.maps.model.LatLng
import com.amap.api.maps.model.PolylineOptions
import com.amap.api.navi.AMapNavi
import com.amap.api.navi.AMapNaviListener
import com.amap.api.navi.AMapNaviViewListener
import com.amap.api.navi.enums.NaviType
import com.amap.api.navi.enums.NaviType.*
import com.amap.api.navi.model.*
import com.autonavi.tbt.TrafficFacilityInfo
import kotlinx.android.synthetic.main.activity_navigation.*

class NavigationActivity : AppCompatActivity(), AMapNaviListener {
    override fun onNaviInfoUpdate(p0: NaviInfo?) {
    }

    override fun onCalculateRouteSuccess(p0: IntArray?) {
        initLine()
    }

    override fun onCalculateRouteSuccess(p0: AMapCalcRouteResult?) {
        initLine()
    }

    ///添加导航预览
    private fun initLine() {
        val dataList = mutableListOf<LatLng>()
        mAmapNavi.naviPath.coordList.forEach {
            dataList.add(LatLng(it.latitude, it.longitude))
        }
        val line = PolylineOptions().addAll(dataList).width(20f).color(Color.parseColor("#FF6F81D6"))
        line.isUseTexture = true
        line.zIndex(10f)
        val textture = BitmapDescriptorFactory.fromResource(R.mipmap.blue_arrow)
        line.customTexture = textture
        amap?.clear()
        amap?.addPolyline(line)
        amap?.animateCamera(CameraUpdateFactory.newLatLngBounds(mAmapNavi.naviPath.boundsForPath, 10), 1000L, null)

    }

    override fun onCalculateRouteFailure(p0: Int) {
    }

    override fun onCalculateRouteFailure(p0: AMapCalcRouteResult?) {
    }

    override fun onServiceAreaUpdate(p0: Array<out AMapServiceAreaInfo>?) {
    }

    override fun onEndEmulatorNavi() {
    }

    override fun onArrivedWayPoint(p0: Int) {
    }

    override fun onArriveDestination() {
    }

    override fun onPlayRing(p0: Int) {
    }

    override fun onTrafficStatusUpdate() {
    }

    override fun onGpsOpenStatus(p0: Boolean) {
    }

    override fun updateAimlessModeCongestionInfo(p0: AimLessModeCongestionInfo?) {
    }

    override fun showCross(p0: AMapNaviCross?) {
    }

    override fun onGetNavigationText(p0: Int, p1: String?) {
    }

    override fun onGetNavigationText(p0: String?) {
    }

    override fun updateAimlessModeStatistics(p0: AimLessModeStat?) {
    }

    override fun hideCross() {
    }

    override fun onInitNaviFailure() {
    }

    override fun onInitNaviSuccess() {
        mAmapNavi.calculateWalkRoute(NaviLatLng(39.92, 116.53))
    }

    override fun onReCalculateRouteForTrafficJam() {
    }

    override fun updateIntervalCameraInfo(p0: AMapNaviCameraInfo?, p1: AMapNaviCameraInfo?, p2: Int) {
    }

    override fun hideLaneInfo() {
    }

    override fun onNaviInfoUpdated(p0: AMapNaviInfo?) {
    }

    override fun showModeCross(p0: AMapModelCross?) {
    }

    override fun updateCameraInfo(p0: Array<out AMapNaviCameraInfo>?) {
    }

    override fun hideModeCross() {
    }

    override fun onLocationChange(p0: AMapNaviLocation?) {
    }

    override fun onReCalculateRouteForYaw() {
    }

    override fun onStartNavi(p0: Int) {
    }

    override fun notifyParallelRoad(p0: Int) {
    }

    override fun OnUpdateTrafficFacility(p0: Array<out AMapNaviTrafficFacilityInfo>?) {
    }

    override fun OnUpdateTrafficFacility(p0: AMapNaviTrafficFacilityInfo?) {
    }

    override fun OnUpdateTrafficFacility(p0: TrafficFacilityInfo?) {
    }

    override fun onNaviRouteNotify(p0: AMapNaviRouteNotifyData?) {
    }

    override fun showLaneInfo(p0: Array<out AMapLaneInfo>?, p1: ByteArray?, p2: ByteArray?) {
    }

    override fun showLaneInfo(p0: AMapLaneInfo?) {
    }

    private var amap: AMap? = null
    val mAmapNavi by lazy {
        AMapNavi.getInstance(this.applicationContext)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_navigation)
        map_view.onCreate(savedInstanceState)
        amap = map_view.map
        mAmapNavi.addAMapNaviListener(this)
        amap?.setOnMapLoadedListener {
            amap?.uiSettings?.isZoomControlsEnabled = false
        }
        amap?.mapType = if (Util.getDarkModeStatus(this)) 3 else 1
        initText()
        noTityle()
        start_navigation.setOnClickListener { 
            startActivity(Intent(this,NavigationPageActivity::class.java))
        }
    }

    private fun initText() {
        val textList = mutableListOf<TextView>(walk, bike, car)
        for (i in 0 until textList.size) {
            textList[i].setOnClickListener {
                when (i) {
                    0 -> {
                        mAmapNavi.calculateWalkRoute(NaviLatLng(39.92, 116.53))
                    }
                    1 -> {
                        mAmapNavi.calculateRideRoute(NaviLatLng(39.92, 116.53))
                    }
                    2 -> {
                        var mLocationClient: AMapLocationClient? = null//定位实例
                        val mLocationOption = AMapLocationClientOption()
                        mLocationOption.isOnceLocationLatest = true //启用单次定位
                        mLocationOption.isOnceLocation = true
                        mLocationClient = AMapLocationClient(this);
                        mLocationClient?.run {
                            setLocationOption(mLocationOption)
                            stopLocation()
                            setLocationListener {
                                mAmapNavi.calculateDriveRoute(NaviPoi("测试", LatLng(it.latitude, it.longitude), "测试一")
                                        , NaviPoi("测试", LatLng(39.92, 116.53), "测试二")
                                        , listOf<NaviPoi>(), DRIVING_DEFAULT)
                            }
                        }
                        mLocationClient?.startLocation()
                    }
                }
                textList.forEach {
                    it.setTextColor(resources.getColor(R.color.textBlack))
                }
                textList[i].setTextColor(resources.getColor(R.color.textBlue))
            }
        }
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
        map_view.onResume()
    }

    override fun onDestroy() {
        super.onDestroy()
        map_view.onDestroy()
    }

    override fun onPause() {
        super.onPause()
        map_view.onPause()
    }

}
