import 'package:easy_app/base_file.dart';
import 'package:easy_app/color_util.dart';
import 'package:easy_app/native/map_view.dart';
import 'package:easy_app/page/map/map_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NavigationPageState();
  }
}

class NavigationPageState extends BaseState<NavigationPage> {
  List<String> selectText = ["驾车", "骑行", "步行"];

  NavigationBloc _bloc;
  NativeMapView _mapView;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = NavigationBloc();
    _mapView = NativeMapView();
    Future.delayed(Duration(seconds: 2)).whenComplete((){
      _mapView.goToLocation();
    });

  }

  @override
  String initAppName() => "月野兔健身中心";

  @override
  Widget initChild() {
    // TODO: implement initChild
    return Column(
      children: <Widget>[
        Expanded(
            child: Container(
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child:_mapView ,
              ),
            ),
            flex: 1),
        Container(
          decoration: BoxDecoration(
              color: ColorUtil.bodyColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          alignment: Alignment.center,
          height: 40,
          child: StreamBuilder<int>(
            initialData: _bloc.index,
            stream: _bloc.indexStream,
            builder: (ctx, short) => ListView.builder(
              padding: EdgeInsets.all(5),
              shrinkWrap: true,
              itemCount: selectText.length,
              itemBuilder: (ctx, index) => MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  highlightElevation: 0,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  color: short.data == index ? Colors.blue : Colors.transparent,
                  onPressed: () {
                    _bloc.changeIndex(index);
                  },
                  child: Text(
                    selectText[index],
                    style: TextStyle(
                        color: short.data == index
                            ? Colors.white
                            : ColorUtil.isDark ? Colors.white : Colors.black),
                  )),
//            semanticChildCount: selectText.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        )
      ],
    );
  }
}
