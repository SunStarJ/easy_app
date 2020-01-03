import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeMapView extends StatefulWidget {
  double height;

  NativeMapView({this.height = 200});

  _MapState _state;

  goToLocation(){
    _state?.goTo();
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    _state = _MapState();
    return _state;
  }
}

class _MapState extends State<NativeMapView> {
  String _nativeName = "com.example.easy_app.map/mapView";
  MethodChannel _methodChannel;
  EventChannel _eventChannel;

  void goTo() {
    _methodChannel.invokeMethod(
        "goto", {"endLng": 114.524334, "endLat": 38.022699, "name": "月野兔健身"});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _methodChannel = MethodChannel("${_nativeName}Method");
    _eventChannel = EventChannel("${_nativeName}Event");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _methodChannel.invokeMethod("destroy");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: widget.height,
      child: AndroidView(
          viewType: _nativeName,
          creationParams: {"lng": 114.524334, "lat": 38.022699},
          creationParamsCodec: const StandardMessageCodec()),
    );
  }
}
