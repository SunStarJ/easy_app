import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class LocationUtil {
  static const Plugin = const MethodChannel("com.example.easy_app.map/locationUtil");
  static const Result = const EventChannel("com.example.easy_app.map/locationUtilStream");
  static const MapPlugin = const MethodChannel("com.example.easy_app.map/mapUtil");
  static const MapName = "com.example.easy_app.map/mapView";
  static void initListener(ValueChanged<Object> f){
    Result.receiveBroadcastStream().listen((data){
      f(data);
    },onError: (e){
      print("error:${e}");
    });
  }

  static void startLocation(){
    print("测试定位");
    Plugin.invokeMethod("startLocation");
  }
}